#!/bin/bash

# Script to run tests on Firebase Test Lab

set -e

echo "🔥 Running Tests on Firebase Test Lab"
echo "====================================="
echo ""

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    echo "❌ Error: gcloud CLI is not installed"
    echo "Install from: https://cloud.google.com/sdk/docs/install"
    exit 1
fi

# Check if project ID is set
if [ -z "$GCP_PROJECT_ID" ]; then
    echo "Enter your GCP Project ID:"
    read -r GCP_PROJECT_ID
fi

echo "Using project: $GCP_PROJECT_ID"
echo ""

# Check if APKs exist
if [ ! -f "build/app/outputs/apk/debug/app-debug.apk" ]; then
    echo "❌ Error: App APK not found"
    echo "Run: ./scripts/build_apks.sh first"
    exit 1
fi

if [ ! -f "build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk" ]; then
    echo "❌ Error: Test APK not found"
    echo "Run: ./scripts/build_apks.sh first"
    exit 1
fi

# Create results bucket if it doesn't exist
BUCKET_NAME="${GCP_PROJECT_ID}-test-results"
if ! gsutil ls "gs://${BUCKET_NAME}" &> /dev/null; then
    echo "Creating storage bucket: gs://${BUCKET_NAME}"
    gsutil mb "gs://${BUCKET_NAME}"
fi

# Generate timestamp for results directory
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
RESULTS_DIR="test-results-${TIMESTAMP}"

echo "🚀 Launching tests on Firebase Test Lab..."
echo ""

# Run tests
gcloud firebase test android run \
  --type instrumentation \
  --app build/app/outputs/apk/debug/app-debug.apk \
  --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
  --device model=flame,version=29,locale=en,orientation=portrait \
  --device model=oriole,version=31,locale=en,orientation=portrait \
  --timeout 10m \
  --results-bucket="gs://${BUCKET_NAME}" \
  --results-dir="${RESULTS_DIR}" \
  --project "${GCP_PROJECT_ID}"

echo ""
echo "✅ Tests completed!"
echo ""
echo "View results:"
echo "  • Firebase Console: https://console.firebase.google.com/project/${GCP_PROJECT_ID}/testlab"
echo "  • Storage Bucket: gs://${BUCKET_NAME}/${RESULTS_DIR}"
echo ""
echo "Download results:"
echo "  gsutil -m cp -r gs://${BUCKET_NAME}/${RESULTS_DIR} ./test-results/"

#!/bin/bash

# Script to build both app and test APKs for Firebase Test Lab

set -e

echo "🔨 Building APKs for Firebase Test Lab"
echo "======================================"
echo ""

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}➜ $1${NC}"
}

# Step 1: Build app APK
print_info "Building app APK..."
flutter build apk --debug
print_success "App APK built successfully"

# Step 2: Build test APKs
print_info "Building test APKs..."
cd android

print_info "Building instrumentation test APK..."
./gradlew app:assembleAndroidTest

print_info "Building debug APK with integration tests..."
./gradlew app:assembleDebug -Ptarget=../integration_test/app_test.dart

cd ..
print_success "Test APKs built successfully"

echo ""
echo "📦 APK Locations:"
echo "  App APK: build/app/outputs/apk/debug/app-debug.apk"
echo "  Test APK: build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk"
echo ""

# Verify APKs exist
if [ -f "build/app/outputs/apk/debug/app-debug.apk" ]; then
    SIZE=$(du -h build/app/outputs/apk/debug/app-debug.apk | cut -f1)
    print_success "App APK exists (Size: $SIZE)"
else
    echo "❌ App APK not found!"
    exit 1
fi

if [ -f "build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk" ]; then
    SIZE=$(du -h build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk | cut -f1)
    print_success "Test APK exists (Size: $SIZE)"
else
    echo "❌ Test APK not found!"
    exit 1
fi

echo ""
print_success "All APKs built successfully! 🎉"
echo ""
echo "Next step: Upload to Firebase Test Lab"
echo "Run: ./scripts/run_testlab.sh"

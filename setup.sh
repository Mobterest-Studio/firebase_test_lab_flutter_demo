#!/bin/bash

# Firebase Test Lab Flutter Demo - Setup Script
# This script helps you set up the project quickly

set -e

echo "🔥 Firebase Test Lab Flutter Demo - Setup Script"
echo "================================================"
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "ℹ $1"
}

# Check if Flutter is installed
echo "Checking prerequisites..."
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed"
    echo "Please install Flutter from: https://docs.flutter.dev/get-started/install"
    exit 1
fi
print_success "Flutter is installed: $(flutter --version | head -n 1)"

# Check if Firebase CLI is installed
if ! command -v firebase &> /dev/null; then
    print_warning "Firebase CLI is not installed"
    echo "Install it with: curl -sL https://firebase.tools | bash"
    read -p "Continue without Firebase CLI? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    print_success "Firebase CLI is installed: $(firebase --version)"
fi

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    print_warning "Google Cloud SDK is not installed"
    echo "Install it from: https://cloud.google.com/sdk/docs/install"
    read -p "Continue without gcloud? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    print_success "Google Cloud SDK is installed: $(gcloud --version | head -n 1)"
fi

echo ""
print_info "Installing Flutter dependencies..."
flutter pub get
print_success "Dependencies installed"

echo ""
print_info "Running Flutter doctor..."
flutter doctor

echo ""
print_success "Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run tests locally: flutter test"
echo "2. Run integration tests: flutter test integration_test"
echo "3. Build APKs: ./scripts/build_apks.sh"
echo "4. Setup Firebase: Follow TUTORIAL.md"
echo ""
echo "For detailed instructions, see:"
echo "  - README.md - Quick start guide"
echo "  - TUTORIAL.md - Step-by-step tutorial"
echo "  - BLOG_POST.md - Comprehensive guide"
echo ""
print_success "Happy testing! 🚀"

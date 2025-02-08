#!/bin/bash

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="${PROJECT_ROOT}/"

# 检查必要的工具
function checkPrerequisites() {
    echo "Checking prerequisites..."
    command -v flutter >/dev/null 2>&1 || { echo "Flutter is required but not installed. Aborting." >&2; exit 1; }
    command -v dart >/dev/null 2>&1 || { echo "Dart is required but not installed. Aborting." >&2; exit 1; }
}

# 验证项目结构
function validateProject() {
    echo "Validating project structure..."
    if [ ! -f "${APP_DIR}/pubspec.yaml" ]; then
        echo "Error: pubspec.yaml not found in ${APP_DIR}"
        echo "Make sure you are in the correct directory"
        exit 1
    fi
}

# 清理构建文件
function cleanProject() {
    echo "Cleaning project..."
    cd "${APP_DIR}"
    flutter clean
    
    # 清理 Android 构建文件
    if [ -d "android" ]; then
        cd android
        if [ -f "gradlew" ]; then
            ./gradlew clean
        fi
        cd ..
    fi
    
    # 删除其他构建文件
    rm -rf build/
    rm -rf .dart_tool/
    rm -rf .flutter-plugins
    rm -rf .flutter-plugins-dependencies
}

# 获取依赖并生成代码
function setupDependencies() {
    echo "Setting up dependencies..."
    cd "${APP_DIR}"
    
    # 获取 Flutter 依赖
    flutter pub get
    
    # 生成必要的代码
    dart run build_runner build --delete-conflicting-outputs

    # 确保 Android 构建工具准备就绪
    cd android
    if [ -f "gradlew" ]; then
        ./gradlew --version
    fi
    cd ..
}

# 运行测试
function runTests() {
    echo "Running tests..."
    cd "${APP_DIR}"
    flutter test --no-pub || true
}

# 分析代码
function analyzeCode() {
    echo "Analyzing code..."
    cd "${APP_DIR}"
    flutter analyze
}

# 构建 Android 版本
function buildAndroid() {
    echo "Building Android APK..."
    cd "${APP_DIR}"
    
    # 确保 Flutter SDK 路径正确
    local flutter_sdk=$(which flutter)
    flutter_sdk=$(dirname $(dirname $flutter_sdk))
    echo "Using Flutter SDK at: $flutter_sdk"
    
    # 清理旧的 Gradle 文件
    cd android
    rm -rf .gradle
    rm -rf build
    
    # 确保 gradlew 可执行
    chmod +x gradlew
    
    # 验证 Gradle 设置，添加 --warning-mode all
    echo "Verifying Gradle setup with all warnings..."
    ./gradlew --warning-mode all --version || {
        echo "Error: Failed to verify Gradle setup"
        exit 1
    }
    
    # 运行 Gradle 任务以显示所有警告
    echo "Checking for deprecation warnings..."
    ./gradlew tasks --warning-mode all
    cd ..
    
    # 构建发布版本，添加 warning-mode
    echo "Building release APK..."
    flutter build apk --release --no-tree-shake-icons
}

# 构建 iOS 版本
function buildIOS() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Building iOS..."
        cd "${APP_DIR}"
        flutter build ios --release --no-codesign
    else
        echo "Skipping iOS build (not on macOS)"
    fi
}

# 主函数
function main() {
    echo "Starting build process..."
    
    checkPrerequisites
    validateProject
    cleanProject
    setupDependencies
    analyzeCode
    #runTests
    buildAndroid
    buildIOS
    
    echo "Build completed successfully!"
}

# 错误处理
set -e
trap 'echo "Error: Build failed! See above for details."; exit 1' ERR

# 执行主函数
main 
# Firebase Test Lab CI/CD Demo - Flutter Counter App

Demonstration of integrating **Firebase Test Lab** with **GitHub Actions CI/CD** for Flutter applications.

 

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Repository                         │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ Push/PR
                   ▼
┌─────────────────────────────────────────────────────────────┐
│              GitHub Actions Workflow                         │
│  ┌────────────┐  ┌────────────┐  ┌─────────────────────┐   │
│  │   Setup    │→ │   Build    │→ │   Run Unit Tests    │   │
│  └────────────┘  └────────────┘  └─────────────────────┘   │
│                                                               │
│  ┌──────────────────┐  ┌─────────────────────────────────┐ │
│  │ Build Test APKs  │→ │  Upload to Firebase Test Lab   │ │
│  └──────────────────┘  └─────────────────────────────────┘ │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ Test Execution
                   ▼
┌─────────────────────────────────────────────────────────────┐
│              Firebase Test Lab                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │ Pixel 4  │  │ Pixel 6  │  │ Galaxy   │  │ More...  │   │
│  │ API 29   │  │ API 31   │  │ S21      │  │          │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ Results & Artifacts
                   ▼
┌─────────────────────────────────────────────────────────────┐
│                Test Results Dashboard                        │
│  • Test logs        • Screenshots      • Video recordings   │
│  • Performance data • Crash reports    • Coverage reports   │
└─────────────────────────────────────────────────────────────┘
```
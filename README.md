TKP - TikTok style NAS video player (full-featured template)
==========================================================

Included features:
- Vertical full-screen pager (TikTok-like)
- WebDAV/HTTP loader: supports JSON array of URLs or HTML directory listing parsing
- Auto-play, long-press to pause, swipe to change
- Background preloading and caching to Caches directory
- Remember WebDAV/URL in UserDefaults
- GitHub Actions workflow that produces an unsigned zip ready for re-signing on Windows

How to build:
1. Upload this project to a GitHub repo and push to main. The provided workflow will create an unsigned zip artifact (tkp_unsigned.zip).
2. Download artifact and re-sign using a Windows re-signer (轻松签 / Sideloadly) or sign via Xcode on macOS.
3. Or, open in Xcode on macOS and Archive/Export with proper signing settings.

Notes:
- This is a template and may require adjustments for production use (error handling, video buffering tuning).
- If you want fully automated signed IPA generation, add your cert.p12 and mobileprovision into a certs/ folder and I'll provide a signed workflow.

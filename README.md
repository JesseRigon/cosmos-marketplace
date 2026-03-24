# Cosmos Cloud Marketplace

A personal Cosmos Cloud servapps marketplace with 203+ applications ready for deployment.

## 🚀 Quick Start

Add this marketplace to your Cosmos Cloud instance:

```
https://jesserigon.github.io/cosmos-marketplace/servapps.json
```

Go to **Settings → App Store → Add Repository** in Cosmos Cloud and paste the URL above.

## 📦 How It Works

This marketplace uses **GitHub Actions** to automatically build and deploy:

1. **Push to `master`** triggers the GitHub Actions workflow (`.github/workflows/static.yml`)
2. **Build step** runs `node index.js` to generate `servapps.json` and `index.json`
3. **Deploy step** publishes to GitHub Pages at `https://jesserigon.github.io/cosmos-marketplace/`

**Important**: The JSON files (`servapps.json`, `index.json`) are **NOT committed** to the repo. They are built on-demand by GitHub Actions during deployment.

## 🛠️ Configuration

### config.json

Update these values for your own fork:

```json
{
  "pageUrl": "https://YOUR-USERNAME.github.io/YOUR-REPO",
  "servappsFolder": "servapps",
  "marketIndexUrl": "https://YOUR-USERNAME.github.io/YOUR-REPO/servapps.json"
}
```

### GitHub Pages Setup

1. Go to your repo **Settings → Pages**
2. Set **Source** to: **GitHub Actions** (NOT "Deploy from a branch")
3. Push to `master` to trigger the first deployment
4. Wait 1-2 minutes for the workflow to complete

## 📁 Adding Apps

Apps are stored in `servapps/` directory. Each app needs:

- `description.json` - App metadata (name, description, tags, etc.)
- `cosmos-compose.json` or `docker-compose.yml` - Container configuration
- `icon.png` - App icon
- `screenshots/` - Optional screenshots
- `logo/` - Optional additional logos

The build script (`index.js`) automatically:
- Scans all directories in `servapps/`
- Reads each app's `description.json`
- Generates asset URLs using `pageUrl` from config
- Compiles everything into `servapps.json` and `index.json`

## 🔄 Updating the Marketplace

1. Add/modify apps in `servapps/` directory
2. Commit and push to `master`
3. GitHub Actions automatically rebuilds and redeploys
4. Your marketplace URL updates within 1-2 minutes


## 🔗 URLs

- **Repository**: https://github.com/JesseRigon/cosmos-marketplace
- **Marketplace**: https://jesserigon.github.io/cosmos-marketplace/
- **Servapps JSON**: https://jesserigon.github.io/cosmos-marketplace/servapps.json
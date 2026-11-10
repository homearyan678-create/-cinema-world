# Cinema World — Flutter prototype

This is a UI prototype with fictional sample titles. It does not yet stream movies or fetch live catalogue data.

## Build an APK using only an Android phone

1. Sign in to GitHub in your phone browser.
2. Create a new repository named `cinema-world` (Public or Private).
3. Upload the contents of this ZIP to the repository. Make sure `.github/workflows/build-apk.yml` is included. If GitHub's mobile upload interface hides dot-folders, create the workflow file using the GitHub web editor at `.github/workflows/build-apk.yml` and paste its contents from this ZIP.
4. Open the repository's **Actions** tab.
5. Select **Build Cinema World APK** and press **Run workflow** (or push a commit to `main`).
6. Wait for the workflow to finish successfully.
7. Open the completed workflow run, find **Artifacts**, and download `cinema-world-release-apk`.
8. Extract the downloaded artifact ZIP. Install `app-release.apk` on your Android phone. Android may ask you to allow installs from your browser/files app.

## Important
- This APK is an early UI prototype with fictional placeholder movie cards.
- No live movie catalogue, movie playback, account system or six-hour sync is connected yet.
- Do not distribute this prototype as a finished streaming service.
- Before commercial use, obtain required API licences, content rights, privacy disclosures and store-policy approvals.

## Local build (optional)
`flutter pub get`
`flutter build apk --release`

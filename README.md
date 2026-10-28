
# docker-poc

Repository to host Dockerfiles for **glo-inbuilt** container images.

------------------------------------------------------------------------

## 📦 How to Build Your Images

Follow this process whenever you want to create or modify Dockerfiles in
this repository.

### 1. Create a Working Branch

-   Create a new branch from `develop`.
-   Use a meaningful branch name that reflects the change you are
    introducing.

### 2. Modify or Add a Dockerfile

-   If updating an existing image:
    -   Locate the appropriate directory containing the Dockerfile you
        want to improve.
-   If adding a new image:
    -   Create a new directory with a clear, descriptive name.
    -   Add your Dockerfile inside this directory.

### 3. Commit & Raise a Pull Request

-   Commit your Dockerfile changes to your branch.
-   Raise a Pull Request (PR) against the **develop** branch.
-   Notify the DevOps team by sharing the PR in the Teams channel:\
    **[DevOps Team -- Microsoft
    Teams](https://teams.microsoft.com/l/channel/19%3APVP3sV9vmBMvAciUXEiHPx0Bb7KEqpJ4K6kkMeAhihc1%40thread.tacv2/General?groupId=0a31a945-00b8-43b2-8c6c-9f7f12be0252&tenantId=f4c566ce-a3ce-4b10-b55b-1e9d56ad1b26)**

### 4. Build the Image Using GitHub Actions

Once the PR is approved and merged:

1.  Go to **Actions** in GitHub.
2.  Select the workflow **`Build Docker Image`**.
3.  Click **Run Workflow**.
4.  Choose:
    -   The branch (usually `develop`),
    -   The directory that contains the Dockerfile you updated or added.

The workflow will: - Build the Docker image, - Push it to
**Artifactory** → `glo-docker-local` repository.

------------------------------------------------------------------------

## 🏷️ Image Naming Convention

The pushed image will follow this naming format:

    artifactory.ssnc.dev/glo-docker-local/glo-docker/<folder-name>:<github-workflow-run-id>

-   `<folder-name>` → Name of the directory containing your Dockerfile\
-   `<github-workflow-run-id>` → Unique ID from the GitHub Actions run

You can find the exact image name in the workflow logs under the
**"Image Details"** step.

Use this image name to pull and deploy your newly built container.

------------------------------------------------------------------------

## ✅ Summary

This repository provides a simple GitOps-style workflow where: -
Dockerfiles live in version control, - Changes require PR review, -
Docker images are automatically built via GitHub Actions, - Images are
published to Artifactory following a predictable naming convention.

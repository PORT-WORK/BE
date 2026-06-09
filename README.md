# BE

Railway deployment notes:
- Use Railway for the app server deployment.
- Use Cloudinary for file uploads.
- Set `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET`.
- Railway provides the runtime `PORT` env var, so the app binds to that automatically.

This is not an official Google Project.

This repository contains a simple node.js sample app.

```bash
# run the server in localhost:3000
./app.js

# Compile in the cloud and upload to GCR
gcloud container builds submit . --tag "gcr.io/$(gcloud config list --format 'value(core.project)')/node-demo-app"

# Compile and test in the local environment (needed only for debugging)
docker build . -q
docker images
docker run --name node-demo-app -d --restart=on-failure --net=host -p 3000:3000 image_id
```

## Building in your local machine

If you are building this container in your local machine (not necessary in general, just for debugging), you may be affected by existing issues with Docker on new Ubuntu systems:

* [You may have to enable IP forwarding](https://github.com/moby/moby/issues/490) 

Once these are done, run `sudo reload docker` and try again. 
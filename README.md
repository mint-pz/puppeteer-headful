# Puppeteer Headful

[Github Action](https://github.com/features/actions) for [Puppeteer](https://github.com/GoogleChrome/puppeteer) that can be ran "headful" or not headless.

> Versioning of this container is based on the version of NodeJS in the container

## Purpose
This container is available as a Github Action to allow [Chrome Extension](https://pptr.dev/#?product=Puppeteer&version=v1.18.1&show=api-working-with-chrome-extensions) testing which is not possible in a headless Puppeteer configuration.

## Usage

This installs Puppeteer on top of a [NodeJS](https://nodejs.org) container so you have access to run [npm](https://www.npmjs.com) scripts using args. For this hook we hijack the entrypoint of the [Dockerfile](https://docs.docker.com/engine/reference/builder/) so we can startup [Xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml) before your testing starts.

```yaml
name: Puppeteer Headful CI
on: push
jobs:
  end_to_end_tests:
    name: Run Headful End-to-End Tests 
    runs-on: ubuntu-latest
    env:
      CI: 'true'
    steps:
    - name: Check out code
      uses: actions/checkout@v2
    - name: Install node 
      uses: actions/setup-node@v2-beta
      with:
        node-version: 12.x
    - name: Install stuff 
      run: npm install 
      env:
        PUPPETEER_SKIP_CHROMIUM_DOWNLOAD: 'true'
    - name: Run headful puppeteer tests
      uses: djp3/puppeteer-headful@master
      with:
        args: npm test
```

> Note: You will need to let Puppeteer know not to download Chromium. By setting the env of your install task to PUPPETEER_SKIP_CHROMIUM_DOWNLOAD = 'true' so it does not install conflicting versions of Chromium.

Then you will need to change the way you launch Puppeteer. The code exports an ENV variable `PUPPETEER_EXEC_PATH` that you set at your `executablePath`. This should be undefined locally so it should function perfectly fine locally and on the action.

Below is the minimal bit needed to get a chromium instance launched with the extension for testing.  More complete example at: [Witness Chrome Extension](https://github.com/djp3/witness_chrome_extension)

```javascript
	browser = await puppeteer.launch({
		executablePath: process.env.PUPPETEER_EXEC_PATH, 	// set by docker container in github CI environment
		headless: false, 									// extension are allowed only in headful mode
		args: [
			`--no-sandbox`,									//Required for this to work in github CI environment 
			`--disable-extensions-except=${extensionPath}`,
			`--load-extension=${extensionPath}`
		]
        ...
	});
```

# OCRTool

When applying fancy new AI models on top of documents, the first step in NLP pipelines is often
to extract data out of myriad formats like PDFs and image files.

With the release of the [Live Text](https://support.apple.com/en-gb/guide/iphone/iphcf0b71b0e/ios) feature on
iOS and macOS, Apple also unveiled the VisionKit APIs for extracting text programmaticaly from documents using their
same industry-leading OCR.

We find anecdotally that it's superior to running the same documents through [Tesseract](https://tesseract-ocr.github.io/),
so it seemed worth it to wrap into a little CLI tool.

## Using

Grab the latest Universal macOS binary from the Releases page.

From there, you can run it on any document. Example:

```
$ OCRTool us_passport.jpg
$ OCRTool invoice.pdf
```

## Building

Either open the project in XCode and click Build, or checkout the repo and from the root, run `xcodebuild`.

The output files will be generated in the `build/Release/OCRTool` directory.


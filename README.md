# Exports

Exports is a Dart package for managing and automatically generating your Dart and Flutter project's import statements, providing a clean and efficient approach to handling project dependencies.

## Features

- Generates `*.dart` files containing export statements for every file and directory within specified paths.
- Easily exclude files or directories with glob patterns.
- Reduces the clutter of numerous import statements in your Dart or Flutter files.
- Automatically updates when your file structure changes.
- Easy to configure with flexible rules.

## Usage

1. run the following command to install the package:

```sh
dart pub global activate exports
```

2. Optionally, create ```export.yaml``` in the root of your project to configure the tool. See the [Configuration](#configuration) section for more information.

3. Run the tool:

```sh
exports
```

In this example, the tool will scan through the lib directory and create an ```*.dart``` file in each directory with export statements for all files in that directory. It will not include any files matching the patterns in the ignores list.

## Configuration
```yaml
export:
  - lib/

ignore:
  - "**/*.g.dart"
  - "**/*.freezed.dart"
  - "**/*.gr.dart"
  - "**/_*.dart"
```
MIT License

Copyright (c) 2023 masreplay

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
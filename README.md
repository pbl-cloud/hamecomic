# hamecomic

"hamecomic" is a comic-like picture frame for your pictures.

## Installation

```
git clone git@github.com:pbl-cloud/hamecomic.git
cd hamecomic/pkg
gem install -l hamecomic-0.1.0.gem
```

or add the following to your Gemfile.

```
gem 'hamecomic', git: 'https://github.com/pbl-cloud/hamecomic.git'
```

## Usage

```
Usage: hamecomic [options]
    -i, --image        Image to take faces from (required)
    -m, --mode         Mode to create image {'keikaku' | 'mada' | 'kansha'} (required)
    -o, --output       Output file. '%d' will be replaced by the image number.
    -v, --verbose      Enable verbose mode
    -h, --help         Display this help message.
```

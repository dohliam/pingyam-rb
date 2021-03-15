# pingyam.rb - Cantonese romanization conversion in Ruby

This repo contains a Ruby library and example conversion tool that makes use of the open-licensed [Pingyam Database](https://github.com/kfcd/pingyam) to convert between 11 different Cantonese romanization systems and variants.

## Features

* Converts to and from any Cantonese romanization scheme (including IPA)
* Can convert single and multiple words / whole lines of romanized text
* Handles mixed input (non-Cantonese text is ignored)
* Converter script ready to use on the command-line -- or include the library in your own code

## Included Romanization Systems

In total 11 Cantonese romanization systems are available for conversion using this library. Each variant is identified by a number (`0-10`); this number is also used for identifying the "to" and "from" romanizations to use while converting text.

* `0`: [Yale](https://en.wikipedia.org/wiki/Yale_romanization_of_Cantonese) / 耶魯拼音 - _modified 9-tone Yale_ (Tone numbers)
* `1`: Yale (Tone diacritics)
* `2`: [Cantonese Pinyin](https://en.wikipedia.org/wiki/Cantonese_Pinyin) / 教院拼音
* `3`: [S.L. Wong](https://en.wikipedia.org/wiki/S._L._Wong_(romanisation)) / 黃錫凌 (Tone numbers)
* `4`: S.L. Wong (tone diacritics)
* `5`: [International Phonetic Alphabet](https://en.wikipedia.org/wiki/International_Phonetic_Alphabet) / 國際音標
* `6`: [Jyutping](https://en.wikipedia.org/wiki/Jyutping) / 粵拼
* `7`: [Canton](https://en.wikipedia.org/wiki/Guangdong_Romanization#Cantonese) / 廣州拼音
* `8`: [Sidney Lau](https://en.wikipedia.org/wiki/Sidney_Lau_romanisation) / 劉錫祥
* `9`: [Penkyamp](http://cantonese.wikia.com/wiki/Penkyamp) / 粵語拼音字 (Tone numbers)
* `10`: Penkyamp (tone diacritics)

## Requirements

This library makes use of the latest version of the [Pingyam database](https://github.com/kfcd/pingyam), and expects a file called `pingyambiu` containing the conversion data to be located in a `pingyam` folder in the project root directory. There a number of ways to do this:

* _Easiest method_: Run the `update_database.rb` script to get the latest version of the script
  * Instructions: In the project root directory, enter the following command: `./update_database.rb`
  * If the current version of the database is different than the one on your machine, your local copy will be updated
* Download the file directly from the Pingyam project [here](https://github.com/kfcd/pingyam/blob/master/pingyambiu).
  * Make sure to create a directory called `pingyam` in the project root and copy the file to that directory
* If you have `git` installed, you can clone the database into the root project folder using the following command: `git clone https://github.com/kfcd/pingyam.git
* Download the Pingyam project into a separate location and create a symlink in the current project directory

There are no other special requirements other than a working version of Ruby.

## Usage

This project can be used either as a library (`lib_pingyam.rb`) or as a command-line script (`convert_pingyam.rb`). Details for both types of usage can be found below.

### lib_pingyam

To use the library, make sure to `require` the library file, e.g.:

```ruby
require_relative 'lib_pingyam.rb'
```

Before you can convert text, you need to initialize a `Converter` object:

```ruby
conv = Converter.new
```

By default, this initializes a conversion dictionary that works from Yale to any other romanization system.

To use a different source romanization system, just specify the corresponding index number as an argument when initializing the `Converter` object, e.g.:

```ruby
conv = Converter.new(6)
# => This converts from Jyutping to any other system
```

You can then convert any string of text using the `convert_line` method, which takes a string and an integer representing the target romanization system as arguments:

```ruby
pingyam = "Yale to Jyutping conversion: yut9 yu5 jyun2 wun6"
puts conv.convert_line(pingyam, 6)
# => Yale to Jyutping conversion: jyut6 jyu5 zyun2 wun6
```

Tip: If you provide `11` as the index number when converting, the string will be translated into all of the available systems sequentially, e.g.:

```ruby
pingyam = "yut9 yu5 ping3 yam1 fong1 on3 yat7 laam4"
puts conv.convert_line(pingyam, 11)
# => yut9 yu5 ping3 yam1 fong1 on3 yat7 laam4 
# => yuht yúh ping yām fōng on yāt làahm 
# => jyt9 jy5 ping3 jam1 fong1 on3 jat7 laam4 
# => jyt⁹ jy⁵ pɪŋ³ jɐm¹ fɔŋ¹ ɔn³ jɐt⁷ lam⁴ 
# => _jyt ˏjy ¯pɪŋ 'jɐm 'fɔŋ ¯ɔn 'jɐt ˌlam 
# => jyːt˨ jyː˩˧ pʰɪŋ˧ jɐm˥ fɔːŋ˥ ɔːn˧ jɐt˥ laːm˨˩ 
# => jyut6 jyu5 ping3 jam1 fong1 on3 jat1 laam4 
# => yud6 yu5 ping3 yem1 fong1 on3 yed1 lam4 
# => yuet⁶ yue⁵ ping³ yam¹ fong¹ on³ yat¹ laam⁴ 
# => yeud6 yeu5 penk3 yamp1 fong1 on3 yat1 lam4 
# => yeùd yeú pênk yämp föng ôn yät lam
```

### convert_pingyam

The `convert_pingyam.rb` file found in the root directory is a simple script that demonstrates the use of the `lib_pingyam` library. It allows for quick and easy conversion between arbitrary Cantonese romanization systems on the command-line.

Basic usage:

```bash
./convert_pingyam.rb "This is a test: Yut9 yu5 ping3 yam1 jyun2 wun6"
# => This is a test: yuht yúh ping yām jyún wuhn
```

The above example converts the Cantonese romanization in the provided sentence from Yale (with numerals) into Yale with diacritics. All of the text that is not recognizable as Cantonese romanization (e.g., all of the English text before the colon in the provided sentence) is ignored.

To convert the text into Jyutping instead, just provide the index number for Jyutping (i.e., `6` -- see [list above](#included-romanization-systems)):

```bash
./convert_pingyam.rb "This is a test: Yut9 yu5 ping3 yam1 jyun2 wun6" 6
# => This is a test: jyut6 jyu5 ping3 jam1 zyun2 wun6
```

As can be seen, the text has now been converted into Jyutping romanization. Conversion into other systems is equally easy -- just replace `6` with the index number of the system you wish to use for output.

## To do

* Support for traditional 6-tone Yale (with numerals)
* Conversion of tone numbers to superscript
* Optional HTML output
* Handle files and pipes as input

## See also

* [Pingyam database](https://github.com/kfcd/pingyam)
* [pingyam-js](https://github.com/dohliam/pingyam-js) - Online Cantonese Romanization Converter

## License

* Romanization data: [CC BY](https://github.com/kfcd/pingyam/blob/master/LICENSE)
* All other code: [MIT](LICENSE)

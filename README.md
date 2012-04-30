Pixxxer
=======

Installation
------------
Installation is super easy.  Gems work like that.

    gem install pixxxer

Usage
-----

Pixxxer provides a simple DSL for defining, reading, and writing fixed width data files.

Assuming a record like this:

    Title     Author    Qty  Price
    -----     ------    ---  -----
    Dune      Herbert   0012001295
    012345678901234567890123456789
              1         2         

You can define the following template:

    define_pixxx_template(:book)
        .add_field(:title).as(:string).at_position(0).with_width(10).and
        .add_field(:author).as(:string).at_position(10).with_width(10).and
        .add_field(:quantity).as(:integer).at_position(20).with_width(5).and
        .add_field(:price).as(:float).at_position(25).with_width(5).with_precision(2)

To use the template to parse:

    record = 'Dune      Herbert   0012001295'.depixxxit(:book)
    record[:title].should == 'Dune      '
    record[:author].should == 'Herbert    '
    record[:quantity].should == 120
    record[:price].should == 12.95

To use the template to build a record:

    s = record.pixxxit(:book)
    s.should == 'Dune      Herbert   0012001295'

Data Types
----------
    float
    integer
    string
    ebcdic_string (EBCDIC 4-bit characters)
        dependent on iconv. not currently supported by the version on OS X
        "PIC X(03)"  =>  .as(:abcdic_string).with_width(3)
    comp3 (COBOL signed comp-3 packed field)
        with_width specifies the number of bytes:
        "COMP-3 PIC S9(07)V99"  =>  .as(:comp3).with_width(5).with_precision(2)

Notes:
Most things default to zero. Fields default to strings. `at_position` is zero-based.

Copyright
---------
Copyright(c) 2012 Guy Royse & Alyssa Diaz. See LICENSE for further details.

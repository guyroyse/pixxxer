Pixxxer
=======

Installation
------------
Installation is super easy.  Gems works like that.

	gem install pixxxer

Usage
-----

Pixxxer provide a simple DSL for defining fixed with data and then extensions to String and Hash to build and parse
those records.  It can handle floats, integers, and strings.

Assuming a record like this:

	Title     Author    Qty  Price
	-----     ------    ---  -----
    Dune      Herbert   0012001295
	012345678901234567890123456789
	          1         2         

You can define the follwing template:

	define_pixxx_template(:book)
		.add_field(:title).as_string.at_position(0).with_width(10).and
		.add_field(:author).as_string.at_position(10).with_width(10).and
		.add_field(:quantity).as_integer.at_position(20).with_width(5).and
		.add_field(:price).as_float.at_position(25).with_width(5).with_precision(2)

To use the template to parse:

	record = 'Dune      Herbert   0012001295'.pixxxit(:book)
	record[:title].should == 'Dune      '
	record[:author].should == 'Herbert    '
	record[:quantity].should == 120
	record[:price].should == 12.95

To use the template to build a record:

	s = record.depixxxit(:book)
	s.should == 'Dune      Herbert   0012001295'

Note:
- Most things default to zero
- Fields default to strings
- at_position is zero-based

Copyright
---------
Copyright(c) 2011 Guy Royse & Alyssa Diaz. See LICENSE for further details.

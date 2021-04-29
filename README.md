## README

### About this app
* This app was built in Nov 2015, shortly after I graduated dev bootcamp. It was modeled after this xkcd comic: https://xkcd.com/287/
* My solution features two approaches to solve this np-completeness, a memoized bottom up approach and a recursive approach

### Usage
You can find the live version of this app at https://warm-taiga-41838.herokuapp.com/
First and foremost, some idiosyncracies about this program:
If you would like to skip the registration process, use the email "admin@gmail.com" and the password "password"
Additionally, currently in materialize the styling for buttons is kind of "overlaid" upon current buttons, so buttons can sometimes seem to not work. Make sure to click the text portion of the button, and they always work.

### Introduction

This app presents a solution for a client looking to upload a menu and receive back a list of combinations that add up exactly to a target price specified as a header in the file.


After the header line, data is expected in the format

    :name_of_dish, :price of dish
    e.g.
    $15.05
    mixed fruit,$2.15
    french fries,$2.75
    side salad,$3.35
    hot wings,$3.55
    mozzarella sticks,$4.20
    sampler plate,$5.80

The program will allow dollar signs and decimal places to be missing from amounts and any type of character in the first portion of the row of the CSV, however the program will return an error if:
*	The first line contains a comma
*	Any line in between the first line of data in the last is left blank
*	Any line has additional commas
*	There are duplicate menu items

### Improvements
*	For larger menus and target prices, a recursive solution can quickly run out of memory. I ended up implementing both a recursive solution and a bottom up approach. The bottom up approach is the live version of the app, as it preserves memory better and can 
*	Performance for both methods were improved by substituting the menu options with integers to save memory, then later swapped back out for the correct menu option at the end
*	Added feature tests
*	Added test for duplicate menu options

### Benchmarking
After switching out BigDecimals for integers, there was a pretty large gain in speed. 
I benchmarked the difference between using strings of the actual item names in the menu_hash vs. replacing them with integers and then converting back to item names to present the solutions. The results of different target prices for long_example.txt:

At target price of $40:

	F..Rehearsal -------------------------------------------------
	using strings   9.500000   0.500000  10.000000 ( 10.169749)
	using ints     11.240000   0.280000  11.520000 ( 11.733752)
	--------------------------------------- total: 21.520000sec

                        user     system      total        real
    using strings  10.950000   0.250000  11.200000 ( 11.325119)
    using ints      9.620000   1.040000  10.660000 ( 10.666246)
    ............
    At a target price of $30
    .F..Rehearsal -------------------------------------------------
    using strings   0.710000   0.060000   0.770000 (  0.772387)
    using ints      0.990000   0.020000   1.010000 (  1.014176)
    ---------------------------------------- total: 1.780000sec

                        user     system      total        real
    using strings   0.610000   0.010000   0.620000 (  0.632614)
    using ints      0.810000   0.010000   0.820000 (  0.821617)
    ............

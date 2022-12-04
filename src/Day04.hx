/*
 * Day 4: Camp Cleanup
 * https://adventofcode.com/2022/day/4
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

class SectionRange
{
	var min:Int;
	var max:Int;

	public function new(s:String)
	{
		var strings = s.split('-');
		this.min = Std.parseInt(strings[0]);
		this.max = Std.parseInt(strings[1]);
	}

	public function contains(other:SectionRange):Bool
	{
		return (min <= other.min && max >= other.max);
	}

	public function overlaps(other:SectionRange):Bool
	{
		return (min <= other.max && max >= other.min);
	}

	@:keep
	public function toString():String
	{
		return '$min-$max';
	}
}

class Day04
{
	public static function solve()
	{
		var part1_numRedundantPairs:Int = 0; // Part 1: num pairs with 1 section fully containing the other
		var part2_numOverlappingPairs:Int = 0; // Part 2: num pairs with 1 section partially overlapping the other
		Utils.readInputFile('data/day04/puzzle.in', (line) ->
		{
			var sectionRangeStrings = line.split(',');
			var leftRange = new SectionRange(sectionRangeStrings[0]);
			var rightRange = new SectionRange(sectionRangeStrings[1]);

			if (leftRange.contains(rightRange) || rightRange.contains(leftRange))
			{
				++part1_numRedundantPairs;
				++part2_numOverlappingPairs;
			}
			else if (leftRange.overlaps(rightRange))
			{
				++part2_numOverlappingPairs;
			}
		});

		trace('-- Day 4 Results --');
		trace('[Part 1] Num redundant pairs: ' + part1_numRedundantPairs);
		trace('[Part 2] Num overlapping pairs: ' + part2_numOverlappingPairs);
	}
}

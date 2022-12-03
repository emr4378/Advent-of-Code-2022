/*
 * Day 1: Calorie Counting
 * https://adventofcode.com/2022/day/1
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

class Day01
{
	public static function solve()
	{
		var elves:Array<Int> = [];

		// Read input file line-by-line, parsing out the value of each line and keep tally for each 'elf' as separated by blank lines.
		Utils.readInputFile('data/day01/puzzle.in', (line) ->
		{
			if (elves.length == 0 || line.length == 0)
			{
				elves.push(0);
			}

			if (line.length != 0)
			{
				var value:Null<Int> = Std.parseInt(line);
				if (value != null)
				{
					elves[elves.length - 1] += value;
				}
			}
		});

		// Sort from highest to lowest.
		elves.sort((a, b) -> b - a);

		// Tally the total of the top three elves (if available).
		var topThreeSum:Int = 0;
		for (elfIndex in 0...Std.int(Math.min(3, elves.length)))
		{
			topThreeSum += elves[elfIndex];
		}

		trace('-- Day 1 Results --');
		trace('[Part 1] ' + elves[0]);
		trace('[Part 2] ' + topThreeSum);
	}
}

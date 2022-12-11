/*
 * Day 5: Supply Stacks
 * https://adventofcode.com/2022/day/5
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

using StringTools;

class Day05
{
	public static function solve()
	{
		var moveRegex = ~/move ([0-9]+) from ([0-9]+) to ([0-9]+)/;

		var readingStartStacks:Bool = true;
		var part1_stacks:Array<Array<String>> = new Array();
		var part2_stacks:Array<Array<String>> = new Array();

		Utils.readInputFile('data/day05/puzzle.in', (line) ->
		{
			if (line.length == 0)
			{
				readingStartStacks = false;
				for (i in 0...part1_stacks.length)
				{
					part1_stacks[i].reverse();
					part2_stacks[i].reverse();
				}
			}
			else
			{
				if (readingStartStacks)
				{
					var numStacks:Int = Std.int((line.length + 1) / 4);
					for (i in 0...numStacks)
					{
						if (part1_stacks.length <= i)
						{
							part1_stacks.push(new Array());
							part2_stacks.push(new Array());
						}

						var newItem:String = line.charAt((i * 4) + 1);
						if (!newItem.isSpace(0) && Std.parseInt(newItem) == null)
						{
							part1_stacks[i].push(newItem);
							part2_stacks[i].push(newItem);
						}
					}
				}
				else
				{
					moveRegex.match(line);
					var amount:Int = Std.parseInt(moveRegex.matched(1));
					var fromIndex:Int = Std.parseInt(moveRegex.matched(2)) - 1;
					var toIndex:Int = Std.parseInt(moveRegex.matched(3)) - 1;
					// trace('move $amount from ' + (fromIndex + 1) + ' to ' + (toIndex + 1));

					var part2_sliced = part2_stacks[fromIndex].slice(-amount);
					for (i in 0...amount)
					{
						part1_stacks[toIndex].push(part1_stacks[fromIndex].pop());

						part2_stacks[toIndex].push(part2_sliced[i]);
						part2_stacks[fromIndex].pop();
					}
				}
			}
		});

		var part1_result:String = '';
		var part2_result:String = '';
		for (i in 0...part1_stacks.length)
		{
			part1_result += part1_stacks[i][part1_stacks[i].length - 1];
			part2_result += part2_stacks[i][part2_stacks[i].length - 1];
		}

		trace('-- Day 5 Results --');
		trace('[Part 1] Crates on Top: ' + part1_result);
		trace('[Part 2] Crates on Top: ' + part2_result);
	}
}

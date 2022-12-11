/*
 * Day 6: Tuning Trouble
 * https://adventofcode.com/2022/day/6
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

using StringTools;

class Day06
{
	public static function solve()
	{
		var part1_result:Int = -1; // Num chars processed before the first start-of-packet marker is detected
		var part2_result:Int = -1; // Num chars processed before the first start-of-message marker is detected
		Utils.readInputFile('data/day06/puzzle.in', (line) ->
		{
			var packetSequence:Array<String> = [];
			var messageSequence:Array<String> = [];
			for (i in 0...line.length)
			{
				if (packetSequence.length == 4)
				{
					packetSequence.shift();
				}

				if (messageSequence.length == 14)
				{
					messageSequence.shift();
				}

				packetSequence.push(line.charAt(i));
				messageSequence.push(line.charAt(i));

				if (packetSequence.length == 4 && part1_result == -1)
				{
					if (!containsDuplicates(packetSequence))
					{
						part1_result = i + 1;
					}
				}

				if (messageSequence.length == 14 && part2_result == -1)
				{
					if (!containsDuplicates(messageSequence))
					{
						part2_result = i + 1;
					}
				}

				if (part1_result != -1 && part2_result != -1)
				{
					break;
				}
			}
		});

		trace('-- Day 6 Results --');
		trace('[Part 1] Num processed before start-of-packet: ' + part1_result);
		trace('[Part 2] Num processed before start-of-message: ' + part2_result);
	}

	private static function containsDuplicates(arr:Array<String>):Bool
	{
		for (i in 0...arr.length)
		{
			for (j in(i + 1)...arr.length)
			{
				if (arr[i] == arr[j])
				{
					return true;
				}
			}
		}

		return false;
	}
}

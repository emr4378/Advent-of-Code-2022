/*
 * Day 3: Rucksack Reorganization
 * https://adventofcode.com/2022/day/3
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import haxe.EnumFlags;
import Utils;

using haxe.EnumTools;
using StringTools;

enum GroupRucksack
{
	One;
	Two;
	Three;
}

class Day03
{
	public static function solve()
	{
		var part1PrioritySum:Int = 0;
		var part2PrioritySum:Int = 0;

		var lineIndex:Int = 0;
		var groupBadges:Map<String, EnumFlags<GroupRucksack>> = [];
		Utils.readInputFile('data/day03/puzzle.in', (line) ->
		{
			// Part 1
			{
				var commonItem:String = null;
				var compartmentSize = Std.int(line.length / 2);
				for (leftIndex in 0...compartmentSize)
				{
					for (rightIndex in compartmentSize...line.length)
					{
						var leftItem = line.charAt(leftIndex);
						var rightItem = line.charAt(rightIndex);
						if (leftItem == rightItem)
						{
							commonItem = leftItem;
							break;
						}
					}

					if (commonItem != null)
					{
						break;
					}
				}

				part1PrioritySum += toItemPriority(commonItem);
			}

			// Part 2
			{
				var rucksackIndex:Int = lineIndex % 3;
				if (rucksackIndex == 0)
				{
					groupBadges.clear();
				}

				var rucksack = GroupRucksack.createByIndex(rucksackIndex);
				for (itemIndex in 0...line.length)
				{
					var item:String = line.charAt(itemIndex);

					var badgeRucksacks = groupBadges.exists(item) ? groupBadges[item] : new EnumFlags<GroupRucksack>();
					badgeRucksacks.set(rucksack);
					groupBadges[item] = badgeRucksacks;
				}

				if (rucksackIndex == 2)
				{
					for (badge => rucksacks in groupBadges)
					{
						if (rucksacks.has(GroupRucksack.One) && rucksacks.has(GroupRucksack.Two) && rucksacks.has(GroupRucksack.Three))
						{
							part2PrioritySum += toItemPriority(badge);
						}
					}
				}
			}

			++lineIndex;
		});

		trace('-- Day 3 Results --');
		trace('[Part 1] Priority Sum: ' + part1PrioritySum);
		trace('[Part 2] Priority Sum: ' + part2PrioritySum);
	}

	private static function toItemPriority(itemChar:String):Int
	{
		var itemPriority:Int = itemChar.charCodeAt(0);
		if (itemPriority >= 'A'.code && itemPriority <= 'Z'.code)
		{
			// Uppercase item types A through Z have priorities 27 through 52
			itemPriority -= 'A'.code;
			itemPriority += 27;
		}
		else if (itemPriority >= 'a'.code && itemPriority <= 'z'.code)
		{
			// Lowercase item types a through z have priorities 1 through 26
			itemPriority -= 'a'.code;
			itemPriority += 1;
		}
		return itemPriority;
	}
}

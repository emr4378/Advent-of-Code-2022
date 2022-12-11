/*
 * Day 9: Rope Bridge
 * https://adventofcode.com/2022/day/9
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

using StringTools;

class Knot
{
	public var x:Int;
	public var y:Int;

	public function new(?x:Int = 0, ?y:Int = 0)
	{
		this.x = x;
		this.y = y;
	}

	public function moveTowards(other:Knot)
	{
		var xDiff:Int = other.x - x;
		var yDiff:Int = other.y - y;

		if (Math.abs(xDiff) > 1 || Math.abs(yDiff) > 1)
		{
			x += Std.int(xDiff / Math.abs(xDiff));
			y += Std.int(yDiff / Math.abs(yDiff));
		}
	}

	public function getGridPos():String
	{
		return '($x, $y)';
	}

	@:keep
	public function toString():String
	{
		return '($x, $y)';
	}
}

class Day09
{
	public static function solve()
	{
		var head:Knot = new Knot();
		var tailSegments:Array<Knot> = [for (i in 0...9) new Knot()];

		var part1_visitedPositions:Map<String, Int> = [];
		var part2_visitedPositions:Map<String, Int> = [];

		Utils.readInputFile('data/day09/puzzle.in', (line) ->
		{
			var moveSplit:Array<String> = line.split(' ');
			var moveAmount:Int = Std.parseInt(moveSplit[1]);

			while (moveAmount > 0)
			{
				switch (moveSplit[0])
				{
					case 'U': head.y -= 1;
					case 'D': head.y += 1;
					case 'L': head.x -= 1;
					case 'R': head.x += 1;
				}
				--moveAmount;

				tailSegments[0].moveTowards(head);
				for (i in 1...tailSegments.length)
				{
					tailSegments[i].moveTowards(tailSegments[i - 1]);
				}

				var part1_gridPos = tailSegments[0].getGridPos();
				if (part1_visitedPositions.exists(part1_gridPos))
				{
					part1_visitedPositions[part1_gridPos]++;
				}
				else
				{
					part1_visitedPositions[part1_gridPos] = 1;
				}

				var part2_gridPos = tailSegments[tailSegments.length - 1].getGridPos();
				if (part2_visitedPositions.exists(part2_gridPos))
				{
					part2_visitedPositions[part2_gridPos]++;
				}
				else
				{
					part2_visitedPositions[part2_gridPos] = 1;
				}
			}
		});

		trace('-- Day 9 Results --');
		trace('[Part 1] Num unique positions visited (length 1): ' + Lambda.count(part1_visitedPositions));
		trace('[Part 2] Num unique positions visited (length 10): ' + Lambda.count(part2_visitedPositions));
	}
}

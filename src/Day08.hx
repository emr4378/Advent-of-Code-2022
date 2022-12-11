/*
 * Day 8: Treetop Tree House
 * https://adventofcode.com/2022/day/8
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

using StringTools;

class Day08
{
	public static function solve()
	{
		var treeGrid:Array<Array<Int>> = [];
		Utils.readInputFile('data/day08/puzzle.in', (line) ->
		{
			var treeCells:Array<Int> = [];
			for (i in 0...line.length)
			{
				var treeHeight:Int = Std.parseInt(line.charAt(i));
				treeCells.push(treeHeight);
			}
			treeGrid.push(treeCells);
		});

		var part1_numVisibleTreesFromOutside:Int = 0;
		var part2_bestScenicScore:Int = 0;
		for (y in 0...treeGrid.length)
		{
			for (x in 0...treeGrid[y].length)
			{
				if (isCellVisibleFromOutside(x, y, treeGrid))
				{
					++part1_numVisibleTreesFromOutside;
				}

				var scenicScore:Int = getScenicScore(x, y, treeGrid);
				if (scenicScore > part2_bestScenicScore)
				{
					part2_bestScenicScore = scenicScore;
				}
			}
		}

		trace('-- Day 8 Results --');
		trace('[Part 1] Num visible trees from outside: ' + part1_numVisibleTreesFromOutside);
		trace('[Part 2] Highest scenic score: ' + part2_bestScenicScore);
	}

	private static function isCellVisibleFromOutside(x:Int, y:Int, treeGrid:Array<Array<Int>>):Bool
	{
		if (isCellVisibleFromOutsideInDirection(x, y, treeGrid, -1, 0)
			|| isCellVisibleFromOutsideInDirection(x, y, treeGrid, 1, 0)
			|| isCellVisibleFromOutsideInDirection(x, y, treeGrid, 0, -1)
			|| isCellVisibleFromOutsideInDirection(x, y, treeGrid, 0, 1))
		{
			return true;
		}

		return false;
	}

	private static function isCellVisibleFromOutsideInDirection(x:Int, y:Int, treeGrid:Array<Array<Int>>, dirX:Int, dirY:Int):Bool
	{
		var treeHeight:Int = treeGrid[y][x];

		var nX:Int = x;
		var nY:Int = y;
		while (nX > 0 && nX < treeGrid[y].length - 1 && nY > 0 && nY < treeGrid.length - 1)
		{
			nX += dirX;
			nY += dirY;

			if (treeGrid[nY][nX] >= treeHeight)
			{
				return false;
			}
		}

		return true;
	}

	private static function getScenicScore(x:Int, y:Int, treeGrid:Array<Array<Int>>):Int
	{
		var leftDist = getViewDistance(x, y, treeGrid, -1, 0);
		var rightDist = getViewDistance(x, y, treeGrid, 1, 0);
		var upDist = getViewDistance(x, y, treeGrid, 0, -1);
		var downDist = getViewDistance(x, y, treeGrid, 0, 1);
		return leftDist * rightDist * upDist * downDist;
	}

	private static function getViewDistance(x:Int, y:Int, treeGrid:Array<Array<Int>>, dirX:Int, dirY:Int):Int
	{
		var treeHeight:Int = treeGrid[y][x];
		var viewDist:Int = 0;

		var nX:Int = x;
		var nY:Int = y;
		while (nX > 0 && nX < treeGrid[y].length - 1 && nY > 0 && nY < treeGrid.length - 1)
		{
			nX += dirX;
			nY += dirY;
			++viewDist;

			if (treeGrid[nY][nX] >= treeHeight)
			{
				break;
			}
		}

		return viewDist;
	}
}

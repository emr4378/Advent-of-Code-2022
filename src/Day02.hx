/*
 * Day 2: Rock Paper Scissors
 * https://adventofcode.com/2022/day/2
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

enum abstract ThrowShape(Int) to Int
{
	var Rock = 0;
	var Paper = 1;
	var Scissors = 2;

	public function winsAgainst():ThrowShape
	{
		return cast((this + 2) % 3);
	}

	public function losesAgainst():ThrowShape
	{
		return cast((this + 1) % 3);
	}

	public static function compare(a:ThrowShape, b:ThrowShape):Int
	{
		if (a.winsAgainst() == b)
			return 1;
		if (a.losesAgainst() == b)
			return -1;
		return 0;
	}
}

class Day02
{
	public static function solve()
	{
		var part1Score:Int = 0;
		var part2Score:Int = 0;
		Utils.readInputFile('data/day02/puzzle.in', (line) ->
		{
			var roundSymbols = line.split(' ');

			// 'The first column is what your opponent is going to play'
			var opponentShape:ThrowShape = switch (roundSymbols[0])
			{
				case 'A': ThrowShape.Rock;
				case 'B': ThrowShape.Paper;
				case 'C': ThrowShape.Scissors;
				case _: null;
			};

			// Part 1 - 'The second column must be what you should play in response'
			{
				var myShape:ThrowShape = switch (roundSymbols[1])
				{
					case 'X': ThrowShape.Rock;
					case 'Y': ThrowShape.Paper;
					case 'Z': ThrowShape.Scissors;
					case _: null;
				};
				var outcome:Int = ThrowShape.compare(myShape, opponentShape);

				part1Score += (toShapeScore(myShape) + toOutcomeScore(outcome));
			}

			// Part 2 - 'The second column actually says how the round needs to end'
			{
				var outcome:Int = switch (roundSymbols[1])
				{
					case 'X': -1;
					case 'Y': 0;
					case 'Z': 1;
					case _: null;
				};
				var myShape:ThrowShape = switch (outcome)
				{
					case -1: opponentShape.winsAgainst();
					case 0: opponentShape;
					case 1: opponentShape.losesAgainst();
					case _: null;
				};

				part2Score += (toShapeScore(myShape) + toOutcomeScore(outcome));
			}
		});

		trace('-- Day 2 Results --');
		trace('[Part 1] Score: ' + part1Score);
		trace('[Part 2] Score: ' + part2Score);
	}

	private static function toShapeScore(throwShape:ThrowShape):Int
	{
		return throwShape + 1;
	}

	private static function toOutcomeScore(compareResult:Int):Int
	{
		return 3 + (compareResult * 3);
	}
}

import sys.io.File;
import sys.io.FileInput;

class Main
{
	public static function main()
	{
		// https://adventofcode.com/2022/day/1
		var file:FileInput = File.read('data/puzzle.in', false);
		var elves:Array<Int> = [];

		// Read input file line-by-line, parsing out the value of each line and keep tally for each 'elf' as separated by blank lines.
		try
		{
			while (true)
			{
				var line:String = file.readLine();

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
			}
		}
		catch (e:haxe.io.Eof)
		{
		}

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

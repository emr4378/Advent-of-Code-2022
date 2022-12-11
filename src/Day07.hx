/*
 * Day 7: No Space Left On Device
 * https://adventofcode.com/2022/day/7
 * 
 * Copyright (c) 2022 Eduardo Rodrigues (emr4378)
 */

import Utils;

using StringTools;

class File
{
	public var name:String;
	public var size:Int;

	public var parentFolder:Folder;

	public function new(name:String, size:Int)
	{
		this.name = name;
		this.size = size;
		this.parentFolder = null;
	}
}

class Folder
{
	public var name:String;

	public var files:Array<File>;
	public var folders:Array<Folder>;
	public var size:Int;

	public var parentFolder:Folder;

	public function new(name:String)
	{
		this.name = name;

		this.folders = [];
		this.files = [];
		this.size = 0;

		this.parentFolder = null;
	}

	public function addFile(file:File)
	{
		files.push(file);
		file.parentFolder = this;

		increaseSize(file.size);
	}

	public function addFolder(folder:Folder)
	{
		folders.push(folder);
		folder.parentFolder = this;

		increaseSize(folder.size);
	}

	private function increaseSize(increase:Int)
	{
		this.size += increase;
		if (parentFolder != null)
		{
			parentFolder.increaseSize(increase);
		}
	}
}

class Day07
{
	private static var totalSpace:Int = 70000000;
	private static var minUpdateSpace:Int = 30000000;

	public static function solve()
	{
		var commandRegex = ~/^\$ (\S+)(?: (\S+))*/;
		var folderRegex = ~/^dir (.+)/;
		var fileRegex = ~/^([0-9]+) (.+)/;

		var rootFolder:Folder = new Folder('/');
		var currentFolder:Folder = null;
		var isListing:Bool = false;
		Utils.readInputFile('data/day07/puzzle.in', (line) ->
		{
			if (commandRegex.match(line))
			{
				isListing = false;

				if (commandRegex.matched(1) == 'cd')
				{
					var folderName:String = commandRegex.matched(2);
					if (folderName == '/')
					{
						currentFolder = rootFolder;
					}
					else if (folderName == '..')
					{
						currentFolder = currentFolder.parentFolder;
					}
					else
					{
						for (folder in currentFolder.folders)
						{
							if (folder.name == folderName)
							{
								currentFolder = folder;
								break;
							}
						}
					}
				}
				else if (commandRegex.matched(1) == 'ls')
				{
					isListing = true;
				}
			}
			else if (isListing)
			{
				if (folderRegex.match(line))
				{
					var folderName:String = folderRegex.matched(1);
					currentFolder.addFolder(new Folder(folderName));
				}
				else if (fileRegex.match(line))
				{
					var fileName:String = fileRegex.matched(2);
					var fileSize:Int = Std.parseInt(fileRegex.matched(1));
					currentFolder.addFile(new File(fileName, fileSize));
				}
			}
		});

		var availableSpace:Int = totalSpace - rootFolder.size;
		var spaceToFreeUp:Int = minUpdateSpace - availableSpace;
		var folderToDelete:Folder = part2FolderToDelete(rootFolder, spaceToFreeUp);

		trace('-- Day 7 Results --');
		trace('[Part 1] Sum of all folders <= 100000: ' + part1Sum(rootFolder));
		trace('[Part 2] Size of folder to delete: ' + (folderToDelete != null ? folderToDelete.size : -1));
	}

	// Part 1: Returns the sum of the given folder and all subfolders whose whose folder size is at most 100000.
	private static function part1Sum(currentFolder:Folder):Int
	{
		var sum:Int = 0;
		for (folder in currentFolder.folders)
		{
			if (folder.size <= 100000)
			{
				sum += folder.size;
			}
			sum += part1Sum(folder);
		}
		return sum;
	}

	// Part 2: Returns the size of smallest folder whose size >= minSize.
	private static function part2FolderToDelete(currentFolder:Folder, minSize:Int):Folder
	{
		var folderToDelete:Folder = null;
		if (currentFolder.size >= minSize)
		{
			folderToDelete = currentFolder;
			for (folder in currentFolder.folders)
			{
				folder = part2FolderToDelete(folder, minSize);
				if (folder != null && folder.size < folderToDelete.size)
				{
					folderToDelete = folder;
				}
			}
		}
		return folderToDelete;
	}
}

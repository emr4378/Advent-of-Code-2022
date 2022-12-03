import sys.io.File;
import sys.io.FileInput;

class Utils
{
	public static function readInputFile(fileName:String, lineCallback:(String) -> Void)
	{
		var file:FileInput = File.read(fileName, false);

		try
		{
			while (true)
			{
				lineCallback(file.readLine());
			}
		}
		catch (e:haxe.io.Eof)
		{
		}

		file.close();
	}
}

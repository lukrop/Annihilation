// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
class F // Defines the "owner"
	{
		class common // catagory
		{
			file = "f\common";
			// Defines the function to preInit (the paramArray dosent seem to be constructed at preInit stage).
			class processParamsArray
			{
				preInit = 1;
				postInit = 1;
			};
			class nearPlayer
			{
			};
		};
		class cache
		{
			file = "f\cache";
			class cInit {};
			class cTracker {};
			class gCache {};
			class gUncache {};
		};
	};
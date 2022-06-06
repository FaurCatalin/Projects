#pragma once
#include "RecipeCake.h"
#include "Cake.h"
class CakeMaker
{
public:
	CakeMaker();
	Cake takeCommand(RecipeCake recipe);
};


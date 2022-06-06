#include "CakeMaker.h"
#include<Windows.h>
CakeMaker::CakeMaker(){}
Cake CakeMaker::takeCommand(RecipeCake recipe)
{
	string prajitura;
	prajitura = recipe.getName();
	Cake cake(prajitura);
	Sleep(5000);
	printf("Pofitit prajitura:");
	return cake;
}
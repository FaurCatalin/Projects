#include "CommandTaker.h"
#include<list>
CommandTaker::CommandTaker(){}
bool CommandTaker::checkCarouselOfCakes()
{
	if (carousel.getCurrentCapacity() == 10)
		return true;
	else
		return false;
}
bool CommandTaker::refillCarousel()
{
	if (checkCarouselOfCakes() == true)
		return true;
	else
		return false;
}
Cake CommandTaker::takeCommand(RecipeCake recipe)
{
	if (carousel.getCake(recipe.getName()).getName() == "NuEste")
		return cakeMaker.takeCommand(recipe);
	else
		return carousel.getCake(recipe.getName());

}
list<Cake> CommandTaker::getCakesFromCarousel()
{
	return carousel.auxStorage();
}
list<Cake> CommandTaker::takeCommand(RecipeCake recipe, int nrOfCakes)
{
	list<Cake>::iterator i;
	list<Cake> list,aux;
	int ok = 0;
	aux = CommandTaker::getCakesFromCarousel();
	for (i = aux.begin(); i != aux.end(); i++)
	{
		if (recipe.getName().compare(i->getName()) == 0)
		{
			ok = 1;
			list.push_back(*i);
			nrOfCakes--;
			carousel.getCake(recipe.getName());
			cout << "Comnada a fost efectuata!"<<endl;
		}
	}
	if (ok == 0)
		cout << "Cake-ul nu a fost gasit!";
	return list;
}
Cake CommandTaker::takeCommand(string nameOfCake)
{
	list<Cake>::iterator i;
	list<Cake> aux;
	aux = CommandTaker::getCakesFromCarousel();
	for (i = aux.begin(); i != aux.end(); ++i)
	{
		if (nameOfCake.compare(i->getName()) == 0)
		{
			cout << (*i).getName();
			carousel.getCake(nameOfCake);
			return *i;
		}
	}
}

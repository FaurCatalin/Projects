#include "CommandPanel.h"
#include<list>
CommandPanel::CommandPanel()
{
	RecipeCake prajitura1("Bucuresti",5);
	menu.push_back(prajitura1);
	RecipeCake prajitura2("Dobos",10);
	menu.push_back(prajitura2);
	RecipeCake prajitura3("Kinder",15);
	menu.push_back(prajitura3);
	RecipeCake prajitura4("Ecler",20);
	menu.push_back(prajitura4);
	RecipeCake prajitura5("LavaCake",25);
	menu.push_back(prajitura5);
	RecipeCake prajitura6("ChessCake",30);;
	menu.push_back(prajitura6);
}
void CommandPanel::showProducts()
{
    list<RecipeCake>::iterator i;
    for (i = menu.begin(); i != menu.end(); ++i)
    {
        cout << "*************************" << endl;
        cout << i->getName() << endl;
        cout << "*************************" << endl<<endl;
    }
}
void CommandPanel::showProductsInCarousel()
{
	list<Cake> storage;
	list<Cake>::iterator i;
	storage=commandTaker.getCakesFromCarousel();
	for (i = storage.begin(); i != storage.end(); ++i)
	{
		cout << "***************************" << endl;
		cout << (*i).getName() << endl;
		cout << "***************************" << endl<<endl;
	}
}
void CommandPanel::selesctProduct(string name, int numberOfProducts)
{
	list<RecipeCake>::iterator i;
	int ok = 0;
	for (i = menu.begin(); i != menu.end(); ++i)
	{
		if (name.compare(i->getName())==0)
		{
			ok = 1;
			commandTaker.takeCommand(*i, numberOfProducts);
		}
	}
	if (ok == 0)
		cout << "Produsul nu exista!";
}
void CommandPanel::selectProduct(string name)
{
	commandTaker.takeCommand(name);
	cout << endl;
}
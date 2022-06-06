#include "CaourselOfCake.h"
#include"Cake.h"

CaourselOfCake::CaourselOfCake()
{
	Cake prajitura1("Bucuresti");
	storage.push_back(prajitura1);
	Cake prajitura2("Dobos");
	storage.push_back(prajitura2);
	Cake prajitura3("Kinder");
	storage.push_back(prajitura3);
	Cake prajitura4("Ecler");
	storage.push_back(prajitura4);
	Cake prajitura5("LavaCake");
	storage.push_back(prajitura5);
	Cake prajitura6("ChessCake");
	storage.push_back(prajitura6);
}
bool CaourselOfCake::addCake(Cake cake)
{
	if (storage.size() < maxCapacity)
	{
		storage.push_back(cake);
		return true;
	}
	else
		return false;
}
Cake CaourselOfCake::getCake(string name)
{
	Cake cake,auxiliar("NuEste");
	int ok = 0;
	list<Cake>::iterator i;
	for(i=storage.begin();i!=storage.end();++i)
		if (i->getName() == name)
		{
			ok = 1;
			cake = *i;
			storage.erase(i);
			return cake;
		}
	if (ok == 0)
	{
		return auxiliar;
	}

}
int CaourselOfCake::getCurrentCapacity() { return storage.size(); }
list<Cake> CaourselOfCake::auxStorage()
{
	return storage;
}
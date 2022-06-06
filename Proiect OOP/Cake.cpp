#include "Cake.h"
Cake::Cake(){}
Cake::Cake(string name)
{
	this->name = name;
}
string Cake::getName()
{
	return name;
}


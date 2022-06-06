#pragma once
#include<iostream>
#include<list>
#include"Cake.h"
class CaourselOfCake
{
	list<Cake> storage;
	unsigned int maxCapacity = 10;
	unsigned int lowLimit = 3;
public:
	list<Cake> auxStorage();
	CaourselOfCake();
	bool addCake(Cake cake);
	Cake getCake(string nume);
	int getCurrentCapacity();
};


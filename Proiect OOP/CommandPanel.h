#pragma once
#include<iostream>
#include<list>
#include"CommandTaker.h"
class CommandPanel
{
	list<RecipeCake> menu;
	CommandTaker commandTaker;
public:
	CommandPanel();
	void showProducts();
	void selectProduct(string name);
	void selesctProduct(string name, int numberOfProducts);
	void showProductsInCarousel();
};

#pragma once
#include<iostream>
using namespace std;
class RecipeCake
{
	string name;
	int time;
public:
	RecipeCake();
	RecipeCake(string name, int time);
	string getName();
	int getTime();
};


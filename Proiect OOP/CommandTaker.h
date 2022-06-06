#pragma once
#include<iostream>
#include"RecipeCake.h"
#include"CakeMaker.h"
#include"CaourselOfCake.h"
class CommandTaker
{
    bool checkCarouselOfCakes();
    bool refillCarousel();
    RecipeCake carouselRecipe;
    CakeMaker cakeMaker;
    CaourselOfCake carousel;
public:
    CommandTaker();
    Cake takeCommand(RecipeCake recipe);
    list<Cake> takeCommand(RecipeCake recipe, int nrOfCakes);
    Cake takeCommand(string nameOfCake);
    list<Cake> getCakesFromCarousel();
};


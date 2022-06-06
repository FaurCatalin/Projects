#include<iostream>
#include<string>
#include"CommandPanel.h"
int main()
{
	CommandPanel commandPanel;
	string name1,name2;
	int optiune,cantitae;
	do
	{
		cout << "---------------------------------------------------" << endl;
		cout << "                     MENIU                         " << endl;
		cout << "1.Show products" << endl;
		cout << "2.Select product" << endl;
		cout << "3.Select products" << endl;
		cout << "4.Show products in carousel" << endl;
		cout << "5.Exit" << endl;
		cout << "---------------------------------------------------" << endl;
		cout << "Introduceti optiunea:";
		cin >> optiune;
		switch (optiune)
		{
		case 1: {commandPanel.showProducts(); }break;
		case 2: 
		{
			cout << "Introduceti numele produsului care il doriit:";
			cin >> name2;
			commandPanel.selectProduct(name2); 
		}break;
		case 3: 
		{
			cout << "Introduceti numele produsului care il doriti:";
			cin >> name1;
			cout << "Introduceti cantitataea:";
			cin >> cantitae;
			commandPanel.selesctProduct(name1, cantitae);
		}break;
		case 4: {commandPanel.showProductsInCarousel(); }break;
		default: {cout << "Optiune gresita!" << endl; }break;
		}
	} while (optiune != 5);
	return 0;
}
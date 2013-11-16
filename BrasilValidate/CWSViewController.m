//
//  CWSViewController.m
//  BrasilValidate
//
//  Created by Cleber Santos on 02/11/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import "CWSViewController.h"

#import "CWSBrasilValidate.h"

@interface CWSViewController ()

@end

@implementation CWSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *itens = @[@{@"ie": @"01.004.823/001-12", @"estado": @"AC"},
                          @{@"ie": @"240000048", @"estado": @"AL"},
                          @{@"ie": @"030123459", @"estado": @"AP"},
                          @{@"ie": @"999999990", @"estado": @"AM"},
                          @{@"ie": @"123456-63", @"estado": @"BA"},
                          @{@"ie": @"06000001-5", @"estado": @"CE"},
                          @{@"ie": @"073.00001.001-09", @"estado": @"DF"},
                          @{@"ie": @"999999990", @"estado": @"ES"},
                          @{@"ie": @"10.987.654-7", @"estado": @"GO"},
                          @{@"ie": @"120000385", @"estado": @"MA"},
                          @{@"ie": @"0013000001-9", @"estado": @"MT"},
                          @{@"ie": @"283115947", @"estado": @"MS"},
                          @{@"ie": @"062.307.904/0081", @"estado": @"MG"},
                          @{@"ie": @"15-999999-5", @"estado": @"PA"},
                          @{@"ie": @"06000001-5", @"estado": @"PB"},
                          @{@"ie": @"123.45678-50", @"estado": @"PR"},
                          @{@"ie": @"0321418-40", @"estado": @"PE"},
                          @{@"ie": @"18.1.001.0000004-9", @"estado": @"PE"},
                          @{@"ie": @"012345679", @"estado": @"PI"},
                          @{@"ie": @"99999993", @"estado": @"RJ"},
                          @{@"ie": @"20.040.040-1", @"estado": @"RN"},
                          @{@"ie": @"20.0.040.040-0", @"estado": @"RN"},
                          @{@"ie": @"224/3658792", @"estado": @"RS"},
                          @{@"ie": @"101.62521-3", @"estado": @"RO"},
                          @{@"ie": @"0000000062521-3", @"estado": @"RO"},
                          @{@"ie": @"24006628-1", @"estado": @"RR"},
                          @{@"ie": @"251.040.852", @"estado": @"SC"},
                          @{@"ie": @"110.042.490.114", @"estado": @"SP"},
                          @{@"ie": @"27123456-3", @"estado": @"SE"},
                          @{@"ie": @"29010227836", @"estado": @"TO"}];
    
    for (NSDictionary *item in itens) {
        BOOL valido = [CWSBrasilValidate validarInscricaoEstadual:[item valueForKey:@"ie"] estado:[item valueForKey:@"estado"]];
        NSLog(@"IE %@ %@ eh valido? %@", [item valueForKey:@"ie"], [item valueForKey:@"estado"], ((valido) ? @"SIM" : @"NAO"));
    }
    
    
    
    BOOL valido1 = [CWSBrasilValidate validarCEP:@"81630-070"];
    NSLog(@"CEP eh valido? %@", ((valido1) ? @"SIM" : @"NAO"));
    
    //39.233.318/0001-58   90.676.878/0001-34
    BOOL valido2 = [CWSBrasilValidate validarCNPJ: @"90.676.878/0001-34"];
    NSLog(@"CNPJ eh valido? %@", ((valido2) ? @"SIM" : @"NAO"));
}




- (IBAction)validar:(id)sender
{
    BOOL valido = [CWSBrasilValidate validarInscricaoEstadual:_textFieldIE.text estado:_textFieldEstado.text];
    NSLog(@"Valido? %@", (valido) ? @"SIM" : @"NAO");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

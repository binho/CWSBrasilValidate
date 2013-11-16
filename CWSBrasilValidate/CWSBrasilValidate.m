//
//  CWSBrasilValidate.m
//  BrasilValidate
//
//  Created by Cleber Santos on 02/11/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import "CWSBrasilValidate.h"

@implementation CWSBrasilValidate


/*
    Referencias:
    http://geracodigo.com.br/gerar-documento/ie
    http://forum.imasters.com.br/topic/322873-resolvidovalidar-inscrio-estadual-de-todos-os-estados/
    http://www.sintegra.gov.br/insc_est.html
 */


/**
 *  Validar inscricao estadual
 *
 *  @param ie
 *  @param estado Estado no formato "TO" ou "Tocantins"
 *  @return Valido ou invalido
 */
+ (BOOL)validarInscricaoEstadual:(NSString *)ie estado:(NSString *)estado
{
    // Mantem somente digitos sem separadores
    ie = [[ie componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    if (![ie isEqualToString:@""]) {
        
        if ([ie isEqualToString:@"ISENTO"] || [ie isEqualToString:@"isento"]) {
            return YES;
        }
        
        // Inicio Acre
        if ([estado isEqualToString:@"AC"] || [estado isEqualToString:@"Acre"]) {
            if ([ie length] != 13) {
                return NO;
            } else {
                if (![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]) {
                    return NO;
                } else {
                    int b = 4;
                    int soma = 0;
                    for (int i=0; i <= 10; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                        if(b == 1){b = 9;}
                    }
                    int dig = 11 - (soma % 11);
                    if(dig >= 10){dig = 0;}
                    if( !(dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 11]] intValue])) {
                        return NO;
                    } else{
                        b = 5;
                        soma = 0;
                        for(int i=0;i<=11;i++){
                            soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                            b--;
                            if(b == 1){b = 9;}
                        }
                        int dig = 11 - (soma % 11);
                        if(dig >= 10){dig = 0;}
                        
                        return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 12]] intValue]);
                    }
                }
            }
        }
        // Fim Acre
        
        // Inicio Alagoas
        if ([estado isEqualToString:@"AL"] || [estado isEqualToString:@"Alagoas"]) {
            if ([ie length] != 9){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"24"]){return NO;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    soma *= 10;
                    int dig = soma - ( ( (int)(soma / 11) ) * 11 );
                    if(dig == 10){dig = 0;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Alagoas
        
        // Inicio Amazonas
        if ([estado isEqualToString:@"AM"] || [estado isEqualToString:@"Amazonas"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig;
                if(soma <= 11){dig = 11 - soma;}
                else{
                    int r = soma % 11;
                    if(r <= 1){dig = 0;}
                    else{dig = 11 - r;}
                }
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Amazonas
        
        // Inicio Amapa
        if ([estado isEqualToString:@"AP"] || [estado isEqualToString:@"Amapá"]) {
            if ([ie length] != 9){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"03"]){return NO;}
                else{
                    int p = 0;
                    int d = 0;
                    int i = [[ie substringWithRange:NSMakeRange(0, [ie length]-1)] intValue];
                    if( (i >= 3000001) && (i <= 3017000) ){p = 5; d = 0;}
                    else if( (i >= 3017001) && (i <= 3019022) ){p = 9; d = 1;}
                    else if (i >= 3019023){p = 0; d = 0;}
                    
                    int b = 9;
                    int soma = p;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    int dig = 11 - (soma % 11);
                    if(dig == 10){dig = 0;}
                    else if(dig == 11){dig = d;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Amapa
        
        // Inicio Bahia
        if ([estado isEqualToString:@"BA"] || [estado isEqualToString:@"Bahia"]) {
            if ([ie length] != 8){return NO;}
            else{
                NSArray *arr1 = @[@"0", @"1", @"2", @"3", @"4", @"5", @"8"];
                NSArray *arr2 = @[@"6", @"7", @"9"];
                
                int i = [[ie substringWithRange:NSMakeRange(0, 1)] intValue];
                
                int modulo;
                if ([arr1 containsObject: [NSString stringWithFormat:@"%i", i]]) { modulo = 10; }
                else if ([arr2 containsObject: [NSString stringWithFormat:@"%i", i]]) { modulo = 11; }
                
                int b = 7;
                int soma = 0;
                for(int i=0; i<=5; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                
                int dig;
                i = soma % modulo;
                if (modulo == 10){
                    if (i == 0) { dig = 0; } else { dig = modulo - i; }
                }else{
                    if (i <= 1) { dig = 0; } else { dig = modulo - i; }
                }
                if( !(dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 7]] intValue]) ){return NO;}
                else{
                    int b = 8;
                    int soma = 0;
                    for(int i=0; i<=5; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 7]] intValue] * 2;
                    i = soma % modulo;
                    if (modulo == 10){
                        if (i == 0) { dig = 0; } else { dig = modulo - i; }
                    }else{
                        if (i <= 1) { dig = 0; } else { dig = modulo - i; }
                    }
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 6]] intValue]);
                }
            }
        }
        // Fim Bahia
        
        // Inicio Ceara
        if ([estado isEqualToString:@"CE"] || [estado isEqualToString:@"Ceará"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig = 11 - (soma % 11);
                
                if (dig >= 10){dig = 0;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Ceara
        
        // Inicio Distrito Federal
        if ([estado isEqualToString:@"DF"] || [estado isEqualToString:@"Distrito Federal"]) {
            if ([ie length] != 13){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"07"] ){return NO;}
                else{
                    int b = 4;
                    int soma = 0;
                    for (int i=0; i<=10; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                        if(b == 1){b = 9;}
                    }
                    int dig = 11 - (soma % 11);
                    if(dig >= 10){dig = 0;}
                    
                    if( !(dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 11]] intValue]) ){return NO;}
                    else{
                        b = 5;
                        soma = 0;
                        for(int i=0; i<=11; i++){
                            soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                            b--;
                            if(b == 1){b = 9;}
                        }
                        dig = 11 - (soma % 11);
                        if(dig >= 10){dig = 0;}
                        
                        return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 12]] intValue]);
                    }
                }
            }
        }
        // Fim Distrito Federal
        
        // Inicio Espirito Santo
        if ([estado isEqualToString:@"ES"] || [estado isEqualToString:@"Espirito Santo"]) {
            if ([ie length] != 9){return 0;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int i = soma % 11;
                int dig;
                if (i < 2){dig = 0;}
                else{dig = 11 - i;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Espirito Santo
        
        // Inicio Goias
        if ([estado isEqualToString:@"GO"] || [estado isEqualToString:@"Goias"]) {
            if ([ie length] != 9){return NO;}
            else{
                int s = [[ie substringWithRange:NSMakeRange(0, 2)] intValue];
                if( !( (s == 10) || (s == 11) || (s == 15) ) ){return NO;}
                else{
                    int n = [[ie substringWithRange:NSMakeRange(0, 7)] intValue];
                    
                    if(n == 11094402){
                        if ([[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue] != 0){
                            if ([[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue] != 1){
                                return NO;
                            } else {return YES;}
                        }else {return YES; }
                    }else{
                        int b = 9;
                        int soma = 0;
                        for(int i=0; i<=7; i++){
                            soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                            b--;
                        }
                        int dig;
                        int i = soma % 11;
                        if (i == 0){dig = 0;}
                        else{
                            if(i == 1){
                                if((n >= 10103105) && (n <= 10119997)){dig = 1;}
                                else{dig = 0;}
                            }else{dig = 11 - i;}
                        }
                        return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                    }
                }
            }
        }
        // Fim Goias
        
        // Inicio Maranhao
        if ([estado isEqualToString:@"MA"] || [estado isEqualToString:@"Maranhão"]) {
            if ([ie length] != 9){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"12"]){return NO;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    int dig;
                    int i = soma % 11;
                    if (i <= 1){dig = 0;}
                    else{dig = 11 - i;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Maranhao
        
        // Inicio Mato Grosso
        if ([estado isEqualToString:@"MT"] || [estado isEqualToString:@"Mato Grosso"]) {
            if ([ie length] != 11){return NO;}
            else{
                int b = 3;
                int soma = 0;
                for(int i=0; i<=9; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if(b == 1){b = 9;}
                }
                int dig;
                int i = soma % 11;
                if (i <= 1){dig = 0;}
                else{dig = 11 - i;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 10]] intValue]);
            }
        }
        // Fim Mato Grosso
        
        // Inicio Mato Grosso do Sul
        if ([estado isEqualToString:@"MS"] || [estado isEqualToString:@"Mato Grosso do Sul"]) {
            if ([ie length] != 9){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"28"]){return NO;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    int dig;
                    int i = soma % 11;
                    if (i == 0){dig = 0;}
                    else{dig = 11 - i;}
                    
                    if(dig > 9){dig = 0;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Mato Grosso do Sul
        
        // Inicio Minas Gerais
        if ([estado isEqualToString:@"MG"] || [estado isEqualToString:@"Minas Gerais"]) {
            if ([ie length] != 13){return NO;}
            else{
                NSString *ie2 = [NSString stringWithFormat:@"%@0%@", [ie substringWithRange:NSMakeRange(0, 3)], [ie substringWithRange:NSMakeRange(3, [ie length]-3)]];
                
                int b = 1;
                NSString *soma = @"";
                for (int i=0; i<=11; i++) {
                    soma = [soma stringByAppendingFormat:@"%i", ([[NSString stringWithFormat:@"%c", [ie2 characterAtIndex: i]] intValue] * b)];
                    b++;
                    if(b == 3){b = 1;}
                }
                int s = 0;
                for(int i=0; i<[soma length]; i++){
                    s += [[NSString stringWithFormat:@"%c", [soma characterAtIndex: i]] intValue];
                }
                int i = [[ie2 substringWithRange:NSMakeRange(9, 2)] intValue];
                int dig = i - s;
                if(dig != [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 11]] intValue]){return NO;}
                else{
                    int b = 3;
                    int soma = 0;
                    for(int i=0; i<=11; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                        if(b == 1){b = 11;}
                    }
                    int i = soma % 11;
                    if(i < 2){dig = 0;}
                    else{dig = 11 - i;};
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 12]] intValue]);
                }
            }
        }
        // Fim Minas Gerais
        
        // Inicio Pará
        if ([estado isEqualToString:@"PA"] || [estado isEqualToString:@"Pará"]) {
            if ([ie length] != 9){return 0;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"15"]){return 0;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    int dig;
                    int i = soma % 11;
                    if (i <= 1){dig = 0;}
                    else{dig = 11 - i;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Pará
        
        // Inicio Paraíba
        if ([estado isEqualToString:@"PB"] || [estado isEqualToString:@"Paraíba"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig;
                int i = soma % 11;
                if (i <= 1){dig = 0;}
                else{dig = 11 - i;}
                
                if(dig > 9){dig = 0;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Paraíba
        
        // Inicio Paraná
        if ([estado isEqualToString:@"PR"] || [estado isEqualToString:@"Paraná"]) {
            if ([ie length] != 10){return NO;}
            else{
                int b = 3;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if(b == 1){b = 7;}
                }
                int dig;
                int i = soma % 11;
                if (i <= 1){dig = 0;}
                else{dig = 11 - i;}
                
                if ( !(dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]) ){return NO;}
                else{
                    int b = 4;
                    int soma = 0;
                    for(int i=0; i<=8; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                        if(b == 1){b = 7;}
                    }
                    int i = soma % 11;
                    if(i <= 1){dig = 0;}
                    else{dig = 11 - i;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 9]] intValue]);
                }
            }
        }
        // Fim Paraná
        
        // Inicio Pernambuco
        if ([estado isEqualToString:@"PE"] || [estado isEqualToString:@"Pernambuco"]) {
            if ([ie length] == 9){
                int b = 8;
                int soma = 0;
                for(int i=0; i<=6; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig;
                int i = soma % 11;
                if (i <= 1){dig = 0;}
                else{dig = 11 - i;}
                
                if ( !(dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 7]] intValue]) ){return NO;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b--;
                    }
                    int i = soma % 11;
                    if (i <= 1){dig = 0;}
                    else{dig = 11 - i;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
            else if([ie length] == 14){
                int b = 5;
                int soma = 0;
                for(int i=0; i<=12; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if(b == 0){b = 9;}
                }
                int dig = 11 - (soma % 11);
                if(dig > 9){dig = dig - 10;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 13]] intValue]);
            }
            else{return NO;}
        }
        // Fim Pernambuco
        
        // Inicio Piauí
        if ([estado isEqualToString:@"PI"] || [estado isEqualToString:@"Piauí"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig;
                int i = soma % 11;
                if(i <= 1){dig = 0;}
                else{dig = 11 - i;}
                if(dig >= 10){dig = 0;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Piauí
        
        // Inicio Rio de Janeiro
        if ([estado isEqualToString:@"RJ"] || [estado isEqualToString:@"Rio de Janeiro"]) {
            if ([ie length] != 8){return NO;}
            else{
                int b = 2;
                int soma = 0;
                for(int i=0; i<=6; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if(b == 1){b = 7;}
                }
                int dig;
                int i = soma % 11;
                if (i <= 1){dig = 0;}
                else{dig = 11 - i;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 7]] intValue]);
            }
        }
        // Fim Rio de Janeiro
        
        // Inicio Rio Grande do Norte
        if ([estado isEqualToString:@"RN"] || [estado isEqualToString:@"Rio Grande do Norte"]) {
            if( !( ([ie length] == 9) || ([ie length] == 10) ) ){return NO;}
            else{
                int b = [ie length];
                int s;
                if(b == 9){s = 7;}
                else{s = 8;}
                int soma = 0;
                for(int i=0; i<=s; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                soma *= 10;
                int dig = soma % 11;
                if(dig == 10){dig = 0;}
                
                s += 1;
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: s]] intValue]);
            }
        }
        // Fim Rio Grande do Norte
        
        // Inicio Rio Grande do Sul
        if ([estado isEqualToString:@"RS"] || [estado isEqualToString:@"Rio Grande do Sul"]) {
            if ([ie length] != 10){return NO;}
            else{
                int b = 2;
                int soma = 0;
                for(int i=0; i<=8; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if (b == 1){b = 9;}
                }
                int dig = 11 - (soma % 11);
                if(dig >= 10){dig = 0;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 9]] intValue]);
            }
        }
        // Fim Rio Grande do Sul
        
        // Inicio Rondônia
        if ([estado isEqualToString:@"RO"] || [estado isEqualToString:@"Rondônia"]) {
            if ([ie length] == 9) {
                int b = 6;
                int soma = 0;
                for(int i=3; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig = 11 - (soma % 11);
                if(dig >= 10){dig = dig - 10;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            } else if ([ie length] == 14) {
                int b = 6;
                int soma = 0;
                for(int i=0; i<=12; i++) {
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                    if(b == 1){b = 9;}
                }
                int dig = 11 - (soma % 11);
                if (dig > 9){dig = dig - 10;}
                
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 13]] intValue]);
            } else {
                return NO;
            }
        }
        // Fim Rondônia
        
        // Inicio Roraima
        if ([estado isEqualToString:@"RR"] || [estado isEqualToString:@"Roraima"]) {
            if ([ie length] != 9){return NO;}
            else{
                if(![[ie substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"24"]){return NO;}
                else{
                    int b = 1;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b++;
                    }
                    int dig = soma % 9;
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
                }
            }
        }
        // Fim Roraima
        
        // Inicio Santa Catarina
        if ([estado isEqualToString:@"SC"] || [estado isEqualToString:@"Santa Catarina"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig = 11 - (soma % 11);
                if (dig <= 1){dig = 0;}
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Santa Catarina
        
        // Inicio São Paulo
        if ([estado isEqualToString:@"SP"] || [estado isEqualToString:@"São Paulo"]) {
            if( [[[ie substringWithRange:NSMakeRange(0, 1)] uppercaseString] isEqualToString:@"P"] ){
                if ([ie length] != 13){return NO;}
                else{
                    int b = 1;
                    int soma = 0;
                    for(int i=1; i<=8; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b++;
                        if(b == 2){b = 3;}
                        if(b == 9){b = 10;}
                    }
                    int dig = soma % 11;
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 9]] intValue]);
                }
            }else{
                if ([ie length] != 12){return NO;}
                else{
                    int b = 1;
                    int soma = 0;
                    for(int i=0; i<=7; i++){
                        soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                        b++;
                        if(b == 2){b = 3;}
                        if(b == 9){b = 10;}
                    }
                    int dig = soma % 11;
                    if(dig > 9){dig = 0;}
                    
                    if(dig != [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]){return NO;}
                    else{
                        int b = 3;
                        int soma = 0;
                        for(int i=0; i<=10; i++){
                            soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                            b--;
                            if(b == 1){b = 10;}
                        }
                        int dig = soma % 11;
                        return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 11]] intValue]);
                    }
                }
            }
        }
        // Fim São Paulo
        
        // Inicio Sergipe
        if ([estado isEqualToString:@"SE"] || [estado isEqualToString:@"Sergipe"]) {
            if ([ie length] != 9){return NO;}
            else{
                int b = 9;
                int soma = 0;
                for(int i=0; i<=7; i++){
                    soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                    b--;
                }
                int dig = 11 - (soma % 11);
                if (dig > 9){dig = 0;}
                return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 8]] intValue]);
            }
        }
        // Fim Sergipe
        
        // Inicio Tocantins
        if ([estado isEqualToString:@"TO"] || [estado isEqualToString:@"Tocantins"]) {
            if ([ie length] != 11){return NO;}
            else{
                NSString *s = [ie substringWithRange:NSMakeRange(2, 2)];
                if( !( ([s isEqualToString:@"01"]) || ([s isEqualToString:@"02"]) || ([s isEqualToString:@"03"]) || ([s isEqualToString:@"99"]) ) ){return NO;}
                else{
                    int b = 9;
                    int soma = 0;
                    for(int i=0; i<=9; i++){
                        if( !((i == 2) || (i == 3)) ){
                            soma += [[NSString stringWithFormat:@"%c", [ie characterAtIndex: i]] intValue] * b;
                            b--;
                        }
                    }
                    int dig;
                    int i = soma % 11;
                    if(i < 2){dig = 0;}
                    else{dig = 11 - i;}
                    
                    return (dig == [[NSString stringWithFormat:@"%c", [ie characterAtIndex: 10]] intValue]);
                }
            }
        }
        // Fim Tocantins
        
    }
    
    return NO;
}





+ (BOOL)validarCPF:(NSString *)cpf {
    
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(cpf == nil) return NO;
    
    if ([cpf length] != 11) return NO;
    
    if (([cpf isEqual:@"00000000000"]) ||
        ([cpf isEqual:@"11111111111"]) ||
        ([cpf isEqual:@"22222222222"]) ||
        ([cpf isEqual:@"33333333333"]) ||
        ([cpf isEqual:@"44444444444"]) ||
        ([cpf isEqual:@"55555555555"]) ||
        ([cpf isEqual:@"66666666666"]) ||
        ([cpf isEqual:@"77777777777"]) ||
        ([cpf isEqual:@"88888888888"]) ||
        ([cpf isEqual:@"99999999999"])) return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[cpf substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[cpf substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[cpf substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck)) return YES;
    return NO;
}




+ (BOOL)validarCEP:(NSString *)cep
{
    //NSString *regex = @"^[0-9]{2}\\.[0-9]{3}-[0-9]{3}$";
    NSString *regex = @"^[0-9]{5}-[0-9]{3}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject: cep];
}



+ (BOOL)validarCNPJ:(NSString *)cnpj
{
    // Mantem somente numeros
    cnpj = [[cnpj componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    if ([cnpj length] != 14) return NO;
    
    int calcularUm = 0;
    int calcularDois = 0;
    for (int i = 0, x = 5; i <= 11; i++, x--) {
        x = (x < 2) ? 9 : x;
        int number = [[cnpj substringWithRange:NSMakeRange(i, 1)] intValue];
        calcularUm += number * x;
    }
    for (int i = 0, x = 6; i <= 12; i++, x--) {
        x = (x < 2) ? 9 : x;
        int numberDois = [[cnpj substringWithRange:NSMakeRange(i, 1)] intValue];
        calcularDois += numberDois * x;
    }
    
    int digitoUm = ((calcularUm % 11) < 2) ? 0 : 11 - (calcularUm % 11);
    int digitoDois = ((calcularDois % 11) < 2) ? 0 : 11 - (calcularDois % 11);
    
    if (digitoUm != [[cnpj substringWithRange:NSMakeRange(12, 1)] intValue] || digitoDois != [[cnpj substringWithRange:NSMakeRange(13, 1)] intValue]) {
        return NO;
    }
    return YES;
}



@end
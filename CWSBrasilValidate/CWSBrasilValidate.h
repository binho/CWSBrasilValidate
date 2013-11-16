//
//  CWSBrasilValidate.h
//  BrasilValidate
//
//  Created by Cleber Santos on 02/11/13.
//  Copyright (c) 2013 Cleber Santos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWSBrasilValidate : NSObject


+ (BOOL)validarInscricaoEstadual:(NSString *)ie estado:(NSString *)estado;
+ (BOOL)validarCPF:(NSString *)cpf;
+ (BOOL)validarCEP:(NSString *)cep;
+ (BOOL)validarCNPJ:(NSString *)cnpj;

@end

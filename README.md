# CWSBrasilValidate

Validação de Inscrição estadual (IE), CPF, CNPJ e CEP.

## Instalação

Adicione os arquivos `CWSBrasilValidate.h` e `CWSBrasilValidate.m` ao seu projeto.

## Exemplo de uso

Incluir CWSBrasilValidate.h
``` objc
#import "CWSBrasilValidate.h"
```

Validar IE:
``` objc
BOOL valido = [CWSBrasilValidate validarInscricaoEstadual:[item valueForKey:@"ie"] estado:[item valueForKey:@"estado"]];
NSLog(@"IE: %@ Estado: %@ valido: %@", [item valueForKey:@"ie"], [item valueForKey:@"estado"], ((valido) ? @"SIM" : @"NAO"));
```

Validar CNPJ:
``` objc
BOOL valido = [CWSBrasilValidate validarCNPJ: @"90.676.878/0001-34"];
NSLog(@"CNPJ valido? %@", ((valido) ? @"SIM" : @"NAO"));
```

Validar CEP:
``` objc
BOOL valido = [CWSBrasilValidate validarCEP:@"81630-070"];
NSLog(@"CEP valido? %@", ((valido) ? @"SIM" : @"NAO"));
```

//
//  ViewController.m
//  RSAUtil
//
//  Created by ideawu on 7/14/15.
//  Copyright (c) 2015 ideawu. All rights reserved.
//

#import "ViewController.h"
#import "RSA.h"
#import <CommonCrypto/CommonCrypto.h>

@interface ViewController ()

@end

@implementation ViewController


int HexToAsc(char *pDst, char *pSrc, int nSrcLen)
{
    for(int i=0; i<nSrcLen; i+=2)
    {
        //输出高4位
        if(*pSrc>='0' && *pSrc<='9')
        {
            *pDst = (*pSrc - '0') << 4;
        }
        else if(*pSrc>='A' && *pSrc<='F')
        {
            *pDst = (*pSrc - 'A' + 10) << 4;
        }
        else
        {
            *pDst = (*pSrc - 'a' + 10) << 4;
        }
        
        pSrc++;
        
        // 输出低4位
        if(*pSrc>='0' && *pSrc<='9')
        {
            *pDst |= *pSrc - '0';
        }
        else if(*pSrc>='A' && *pSrc<='F')
        {
            *pDst |= *pSrc - 'A' + 10;
        }
        else
        {
            *pDst |= *pSrc - 'a' + 10;
        }
        
        pSrc++;
        pDst++;
    }
    //返回目标数据长度
    return nSrcLen / 2;
}

- (void)viewDidLoad {
	[super viewDidLoad];

    NSString *keyhandle = @"22883D2703FB2C44C43C355C31067AA7EAE1548BF0A7119C3F7A2C5E6F3B10BF39D91597290F5C83A763BE157B8848CF03AEF70C4534520DA3E070E27B6F4336233189BD30306E2DF23A9E3011F059FBB3F5BC3D259C533A67CB267A81F1B53E0E8BB2EA62ADFE068F4DFF8AC705391C60B04719589B5F4B443B211BEB40040D1F4AA7EC0A102A7CEBF236531C2242987CBD17D0AAD88789B15696015702EFB70EA8648392531F656CFEB3CB6A1F18F45431AE9F12FB0826DC7F9D35B7E82D207C512CDCD4B00C2D36B28D352931AFB0F496FED8A03B8D41262D1DC9483A59D0DE25E7EC99C8AB498A65DB781CB5D61BB0480FECA2ACB1EC5A24A63DAA7AB1730EFA71FF268E9098E42EA64277E862E00E11EA66F352A58F47F0D94BE93A3152";
    
    
    char pOut[1024] = {0};
    
    int outdatalen = HexToAsc(pOut, [keyhandle UTF8String], [keyhandle length]);
    
    char poutHash[35] = {0};
    
    CC_SHA256(pOut, outdatalen, poutHash);
    
    

	NSString *pubkey = @"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI2bvVLVYrb4B0raZgFP60VXY\ncvRmk9q56QiTmEm9HXlSPq1zyhyPQHGti5FokYJMzNcKm0bwL1q6ioJuD4EFI56D\na+70XdRz1CjQPQE3yXrXXVvOsmq9LsdxTFWsVBTehdCmrapKZVVx6PKl7myh0cfX\nQmyveT/eqyZK1gYjvQIDAQAB\n-----END PUBLIC KEY-----";
	NSString *privkey = @"-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMMjZu9UtVitvgHS\ntpmAU/rRVdhy9GaT2rnpCJOYSb0deVI+rXPKHI9Aca2LkWiRgkzM1wqbRvAvWrqK\ngm4PgQUjnoNr7vRd1HPUKNA9ATfJetddW86yar0ux3FMVaxUFN6F0KatqkplVXHo\n8qXubKHRx9dCbK95P96rJkrWBiO9AgMBAAECgYBO1UKEdYg9pxMX0XSLVtiWf3Na\n2jX6Ksk2Sfp5BhDkIcAdhcy09nXLOZGzNqsrv30QYcCOPGTQK5FPwx0mMYVBRAdo\nOLYp7NzxW/File//169O3ZFpkZ7MF0I2oQcNGTpMCUpaY6xMmxqN22INgi8SHp3w\nVU+2bRMLDXEc/MOmAQJBAP+Sv6JdkrY+7WGuQN5O5PjsB15lOGcr4vcfz4vAQ/uy\nEGYZh6IO2Eu0lW6sw2x6uRg0c6hMiFEJcO89qlH/B10CQQDDdtGrzXWVG457vA27\nkpduDpM6BQWTX6wYV9zRlcYYMFHwAQkE0BTvIYde2il6DKGyzokgI6zQyhgtRJ1x\nL6fhAkB9NvvW4/uWeLw7CHHVuVersZBmqjb5LWJU62v3L2rfbT1lmIqAVr+YT9CK\n2fAhPPtkpYYo5d4/vd1sCY1iAQ4tAkEAm2yPrJzjMn2G/ry57rzRzKGqUChOFrGs\nlm7HF6CQtAs4HC+2jC0peDyg97th37rLmPLB9txnPl50ewpkZuwOAQJBAM/eJnFw\nF5QAcL4CYDbfBKocx82VX/pFXng50T7FODiWbbL4UnxICE0UBFInNNiWJxNEb6jL\n5xd0pcy9O2DOeso=\n-----END PRIVATE KEY-----";

	NSString *originString = @"hello world!";
	for(int i=0; i<4; i++){
		originString = [originString stringByAppendingFormat:@" %@", originString];
	}
	NSString *encWithPubKey;
	NSString *decWithPrivKey;
	NSString *encWithPrivKey;
	NSString *decWithPublicKey;
	
	NSLog(@"Original string(%d): %@", (int)originString.length, originString);
	
	// Demo: encrypt with public key
	encWithPubKey = [RSA encryptString:originString publicKey:pubkey];
	NSLog(@"Enctypted with public key: %@", encWithPubKey);
	// Demo: decrypt with private key
	decWithPrivKey = [RSA decryptString:encWithPubKey privateKey:privkey];
	NSLog(@"Decrypted with private key: %@", decWithPrivKey);
	
	// by PHP
	encWithPubKey = @"CKiZsP8wfKlELNfWNC2G4iLv0RtwmGeHgzHec6aor4HnuOMcYVkxRovNj2r0Iu3ybPxKwiH2EswgBWsi65FOzQJa01uDVcJImU5vLrx1ihJ/PADUVxAMFjVzA3+Clbr2fwyJXW6dbbbymupYpkxRSfF5Gq9KyT+tsAhiSNfU6akgNGh4DENoA2AoKoWhpMEawyIubBSsTdFXtsHK0Ze0Cyde7oI2oh8ePOVHRuce6xYELYzmZY5yhSUoEb4+/44fbVouOCTl66ppUgnR5KjmIvBVEJLBq0SgoZfrGiA3cB08q4hb5EJRW72yPPQNqJxcQTPs8SxXa9js8ZryeSxyrw==";
	decWithPrivKey = [RSA decryptString:encWithPubKey privateKey:privkey];
	NSLog(@"(PHP enc)Decrypted with private key: %@", decWithPrivKey);
	
	// Demo: encrypt with private key
	// TODO: encryption with private key currently NOT WORKING YET!
	//encWithPrivKey = [RSA encryptString:originString privateKey:privkey];
	//NSLog(@"Enctypted with private key: %@", encWithPrivKey);

	// Demo: decrypt with public key
	encWithPrivKey = @"aQkSJwaYppc2dOGEOtgPnzLYX1+1apwqJga2Z0k0cVCo7vCqOY58PyVuhp49Z+jHyIEmIyRLsU9WOWYNtPLg8XDnt1WLSst5VNyDlJJehbvm7gbXewxrPrG+ukZgo11GYJyU42DqNr59D3pQak7P2Ho6zFvN0XJ+lnVXJ1NTmgQFQYeFksTZFmJmQ5peHxpJy5XBvqjfYOEdlkeiiPKTnTQaQWKJfC9CRtWfTTYM2VKMBSTB0eNWto5XAu5BvgEgTXzndHGzsWW7pOHLqxVagr0xhNPPCB2DRE5PClE2FD9qNv0JcSMnUJ8bLvk6Yeh7mMDObJ4kBif5G9VnHjTqTg==";
	decWithPublicKey = [RSA decryptString:encWithPrivKey publicKey:pubkey];
	NSLog(@"(PHP enc)Decrypted with public key: %@", decWithPublicKey);
}


/**
 *
 *  priv:
        17:36:c4:19:47:36:95:f7:45:f9:3b:13:5f:3c:1b:
        8c:1c:95:9c:92:aa:db:eb:7a:06:62:08:32:1a:bb:
        b7:57
    pub:
        04:e4:34:db:8f:f5:a0:fa:5a:e0:ca:f9:c7:47:53:
        6d:ca:72:76:94:2f:67:a8:fd:5e:1d:6e:b0:d8:04:
        b9:6c:8a:e0:6b:b6:9f:c0:85:ee:67:5d:6f:58:b7:
        e5:a4:79:2e:11:11:1c:0e:d2:14:52:4d:e4:7e:c1:
        7d:40:4a:3e:59

 *
 *
 */
- (void)TestECCAlg
{
    
}

@end

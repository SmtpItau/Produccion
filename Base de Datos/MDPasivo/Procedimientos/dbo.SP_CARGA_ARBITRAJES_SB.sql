USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_ARBITRAJES_SB]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_ARBITRAJES_SB]
AS
BEGIN
    BEGIN TRAN
    EXEC SP_DELETE_ARBITRAJES_SB

	INSERT INTO dbo.ARBITRAJES	
    SELECT C.MOFech,
            C.MoTipope,
            CASE G.CLTIPCLI
            WHEN 8 THEN G.CLGENERIC
            ELSE C.MORUTCLI
            END,
            CASE G.CLTIPCLI
            WHEN 8 THEN 'S'
            ELSE '0'
            END,
            C.MoCodMon,
            ROUND(C.MOMONMO,4),
            PrecioC = CASE MoTipope
                        WHEN 'V' THEN MOParme
                        WHEN 'C' THEN MOParme
                      END,
            PrecioV = CASE MoTipope
                        WHEN 'C' THEN Mopartr
                        WHEN 'V' THEN Mopartr
                      END,
            MONLUSD = CASE 
                        WHEN C.MoCodMon IN('EUR', 'GBP', 'AUD', 'NZD', 'SDR') THEN
                            CASE C.MoTipope
                            WHEN 'V' THEN ROUND(C.MOMONMO,4) * MOParme
                            WHEN 'C' THEN ROUND(C.MOMONMO,4) * MOParme
                            END
                        ELSE 
                            CASE C.MoTipope
                            WHEN 'V' THEN C.MOMONMO / Mopartr
                            WHEN 'C' THEN C.MOMONMO / MOParme
                            END
                      END, 
            'BBVA',
            Moticam,
            UTILUSD = CASE 
                        WHEN MOCodCnv IN('EUR', 'GBP', 'AUD', 'NZD', 'SDR') THEN 
                            CASE C.MoTipope
                            WHEN 'C' THEN ROUND(C.MOMONMO * (Mopartr - MOParme),4)
                            WHEN 'V' THEN ROUND(C.MOMONMO * (MOParme - Mopartr),4)
                            END
                        ELSE 
                            CASE C.MoTipope
                            WHEN 'C' THEN (C.MOMONMO / MOParme) - (C.MOMONMO / Mopartr)
                            WHEN 'V' THEN (C.MOMONMO / Mopartr) - (C.MOMONMO / MOParme)
                            END                        
                      END,
            UTILDIA = CASE 
                        WHEN MOCodCnv IN('EUR', 'GBP', 'AUD', 'NZD', 'SDR') THEN 
                            CASE C.MoTipope
                            WHEN 'C' THEN ROUND(C.MOMONMO * (Mopartr - MOParme),4) * MOticam
                            WHEN 'V' THEN ROUND(C.MOMONMO * (MOParme - Mopartr),4) * MOticam
                            END
                        ELSE 
                            CASE C.MoTipope
                            WHEN 'C' THEN (C.MOMONMO / MOParme) - (C.MOMONMO / Mopartr) * MOticam
                            WHEN 'V' THEN (C.MOMONMO / Mopartr) - (C.MOMONMO / MOParme) * MOticam
                            END                        
                      END,
            MOENTRE,
            MORECIB,
            SUBSTRING(C.MoOPer,1,10),
            C.MoFech,
            '12:00:00',
            'INGRESO',
            '19000101',
            '12:00:00',
            'I', 
            0,
            'E'

      FROM CAMBIO..VIEW_MOVIMIENTO_CAMBIO C LEFT JOIN CLIENTE G ON C.MORUTCLI = G.CLRUT
     WHERE DATEPART(DAY,MOFech) = DATEPART(DAY, GETDATE())
       AND DATEPART(MONTH,MOFech) = DATEPART(MONTH, GETDATE())
       AND DATEPART(YEAR,MOFech) = DATEPART(YEAR, GETDATE())
       AND (LTRIM(C.MoOPer) = 'SCAMPOS' Or LTRIM(C.MoOPer) = 'RSCHEIHING' or
           LTRIM(C.MoOPer) = 'EVERDEJO' or LTRIM(C.MoOPer) = 'GBERNASCONI' or
           LTRIM(C.MoOPer) = 'PROJAS' or LTRIM(C.MoOPer) = 'HHORTA' or
           LTRIM(C.MoOPer) = 'ASALVADOR' OR LTRIM(C.MoOPer) = 'RPALMA')
       AND (C.SUBPRODUCTO_DESKMANAGER = 7)
       AND ANULA_USUARIO = ''
       AND CONTABILIZA = 'N'


    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 'SP_CARGA_ARBITRAJES_SB: Cannot insert data into ARBITRAJES '
        ROLLBACK TRAN
        RETURN(1)
    END

    COMMIT TRAN
END

GO

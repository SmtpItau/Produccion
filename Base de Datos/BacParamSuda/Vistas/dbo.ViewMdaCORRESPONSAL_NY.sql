USE [BacParamSuda]
GO
/****** Object:  View [dbo].[ViewMdaCORRESPONSAL_NY]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ViewMdaCORRESPONSAL_NY]
AS
SELECT codigo_contable, Nombre = substring( mnnemo , 1, 3 ) + ' ' + substring( rtrim( ltrim( nombre ) ), 1, 15 ) + ' SW:' + codigo_swift
FROM  BACPARAMsuda..CORRESPONSAL C  left join MONEDA M ON M.mncodmon = C.codigo_moneda
WHERE rut_cliente = 412645828 

/*
select  * from dbo.ViewMdaCORRESPONSAL
*/
GO

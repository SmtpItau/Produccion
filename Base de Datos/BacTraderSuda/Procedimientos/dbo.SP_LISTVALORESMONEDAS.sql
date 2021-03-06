USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTVALORESMONEDAS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTVALORESMONEDAS]
                  (@xfechadesde char(10),@xfechahasta char(10))
as
begin
  select	'nomemp'  = isnull(MDAC.acnomprop,''),
			'rutemp'  = isnull( ( rtrim (convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),
			'fecpro'  = convert(char(10), MDAC.acfecproc, 103),
			'codmon'  = isnull(convert(numeric(5,0), VIEW_VALOR_MONEDA.vmcodigo),0),
			'nommon'  = isnull(VIEW_MONEDA .mnglosa  ,''),
			'valor'   = isnull(VIEW_VALOR_MONEDA.vmvalor,0.0),
			'fecha'   = convert(char(10), VIEW_VALOR_MONEDA.vmfecha, 103),
			'hora'    = convert(char(10),getdate(),108)
 from   MDAC, VIEW_VALOR_MONEDA, VIEW_MONEDA 
 where  VIEW_VALOR_MONEDA.vmcodigo  = VIEW_MONEDA.mncodmon
 and    VIEW_VALOR_MONEDA.vmfecha >= @xfechadesde
 and    VIEW_VALOR_MONEDA.vmfecha  <= @xfechahasta
        and    VIEW_MONEDA.mnmx     <> 'C'
        and    VIEW_MONEDA.mncodmon <> 999
  order by vmcodigo,vmfecha
end
-- sp_listvaloresmonedas '20000317','20000630'
-- sp_caracter

GO

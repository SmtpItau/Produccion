USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SP_LISTADOCP]
                  (@entidad numeric(9))
  as
  begin
  if @entidad <> 0 
    begin
   declare @numero integer
        select  isnull( MDAC.acnomprop, ''),                                                          
  isnull( ( rtrim(convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),   
    isnull(convert(char(10), MDAC.acfecproc,103),''),
               isnull( VIEW_CLIENTE.clnombre , ''),
                isnull( MDRC.rcnombre , ''),
               isnull( MDMO.motipcart, 0), 
               isnull(rtrim(convert(char(10),MDMO.monumdocu))+'-'+convert(char(3),MDMO.mocorrela),''),
                isnull( MDMO.moinstser, ''),                       
               isnull( MDEM.emgeneric, ''),                       
               isnull( convert(char(10), MDMO.mofecemi, 103), ''),
               isnull( convert(char(10), MDMO.mofecven, 103), ''),
               isnull( MDMO.motasemi, 0),
               isnull( MDMO.mobasemi, 0),
           isnull( VIEW_MONEDA .mnnemo, ''), 
               isnull( MDMO.monominal,0),                                                            -- nominal 
                isnull( MDMO.motir,  0),                                                              -- tir
               isnull( MDMO.mopvp, 0),                                                               -- porcentage valor compra 
               isnull( MDMO.motasest, 0),                                                            -- tasa estimada
               isnull( MDCI.civalcomp, 0),                                                            -- valor compra en pesos
               isnull( MDCI.civalcomu, 0),                                                           -- valor compra en unidades monetarias 
               isnull( convert ( char(10), MDMO.mofecinip, 103), '' ),                               -- fecha inicio pacto 
               isnull( convert ( char(10), MDMO.mofecvenp, 103), '' ),                               -- fecha vcto pacto   
               isnull( MDMO.motaspact, 0),                                                           -- tasa pacto
               isnull( MDMO.mobaspact, 0),                                                           -- base pacto
             isnull( VIEW_MONEDA .mnnemo, ''),                                                                            -- nemotecnico moneda del pacto          
               isnull( MDMO.movalinip, 0),                                                           -- valor inicio pacto
                isnull( MDMO.movalvenp, 0),                                                           -- valor vencimiento pacto
               isnull( VIEW_FORMA_DE_PAGO.glosa, '') ,                                                                            -- glosa forma de pago inicio pacto
               isnull( VIEW_FORMA_DE_PAGO.glosa, '') ,                                                                           -- glosa forma de pago vencimiento pacto
                case MDMO.mocondpacto when 'S' then 'CON CUSTODIA' else 'SIN CUSTODIA' end , 
	            case MDMO.mopagohoy  when 'N' then 'PAGO MAIANA'  else '' end,   isnull( inserie,'')
        from   MDMO, 
                       VIEW_CLIENTE, 
                       VIEW_ENTIDAD MDRC, 
                       VIEW_EMISOR MDEM, 
                       MDCI, 
                       MDAC,
                       VIEW_INSTRUMENTO,
                       VIEW_FORMA_DE_PAGO,
                       VIEW_TABLA_GENERAL_DETALLE,
                       VIEW_MONEDA 
         where MDMO.motipoper = 'CP' --and MDMO.mostatreg is null
         and   MDMO.morutcart = @entidad
		 and   MDRC.rcrut     = @entidad
         and    MDMO.morutcart = MDCI.cirutcart
         and    MDMO.monumdocu = MDCI.cinumdocu
         and    MDMO.mocorrela = MDCI.cicorrela
		 and    MDMO.morutcli  = VIEW_CLIENTE.clrut
	     and    MDMO.mocodcli  = VIEW_CLIENTE.clcodigo
		 and    MDMO.morutcart = MDRC.rcrut
		 and    MDMO.morutemi  = MDEM.emrut
		 and    MDMO.mocodigo  = VIEW_INSTRUMENTO.incodigo
         and    VIEW_TABLA_GENERAL_DETALLE.tbcateg   = 204        
         and    convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)  = isnull( MDMO.motipcart, 0)
         and    VIEW_MONEDA .mncodmon  = isnull( MDMO.momonemi, 0)
 --      and    VIEW_MONEDA.mncodmon  = isnull( MDMO.momonpact, 0)
         and    VIEW_FORMA_DE_PAGO.codigo    = isnull( MDMO.moforpagi, 0) 
          order by MDMO.monumoper + MDMO.mocorrela  
    end else
      begin
        select isnull( MDAC.acnomprop, ''),                                                          
			   isnull( ( rtrim(convert( char(9), MDAC.acrutprop ) ) + '-' + MDAC.acdigprop ),'' ),   
			   isnull(convert(char(10),MDAC.acfecproc,103),''),
               isnull( VIEW_CLIENTE.clnombre , ''),
               isnull( MDRC.rcnombre , ''),
               isnull( MDMO.motipcart, 0), 
               isnull(rtrim(convert(char(10),MDMO.monumdocu))+'-'+convert(char(3),MDMO.mocorrela),''),
               isnull( MDMO.moinstser, ''),                       
               isnull( MDEM.emgeneric, ''),                       
               isnull( convert(char(10), MDMO.mofecemi, 103), ''),
               isnull( convert(char(10), MDMO.mofecven, 103), ''),
               isnull( MDMO.motasemi, 0),
               isnull( MDMO.mobasemi, 0),
			   isnull( VIEW_MONEDA .mnnemo, ''), 
               isnull( MDMO.monominal,0),                                                            -- nominal 
               isnull( MDMO.motir,  0),                                                              -- tir
               isnull( MDMO.mopvp, 0),                                                               -- porcentage valor compra 
               isnull( MDMO.motasest, 0),                                                            -- tasa estimada
               isnull( MDCI.civalcomp, 0),                                                            -- valor compra en pesos
               isnull( MDCI.civalcomu, 0),                                                           -- valor compra en unidades monetarias 
               isnull( convert ( char(10), MDMO.mofecinip, 103), '' ),                               -- fecha inicio pacto 
               isnull( convert ( char(10), MDMO.mofecvenp, 103), '' ),                               -- fecha vcto pacto   
               isnull( MDMO.motaspact, 0),                                                           -- tasa pacto
               isnull( MDMO.mobaspact, 0),                                                           -- base pacto
             isnull( VIEW_MONEDA .mnnemo, ''),                                                                            -- nemotecnico moneda del pacto          
               isnull( MDMO.movalinip, 0),                                                           -- valor inicio pacto
                isnull( MDMO.movalvenp, 0),                                                           -- valor vencimiento pacto
               isnull( VIEW_FORMA_DE_PAGO.glosa, '') ,                                                                            -- glosa forma de pago inicio pacto
               isnull( VIEW_FORMA_DE_PAGO.glosa, '') ,                                                                           -- glosa forma de pago vencimiento pacto
                case MDMO.mocondpacto when 'S' then 'CON CUSTODIA' else 'SIN CUSTODIA' end ,
                case mopagohoy  when 'n' then 'pago maïana'  else '' end,
  isnull( inserie,'')
        from    MDMO,
                        VIEW_CLIENTE,
                        VIEW_ENTIDAD MDRC, 
                        VIEW_EMISOR MDEM, 
                        MDCI, 
                        MDAC, 
                        VIEW_INSTRUMENTO, 
                        VIEW_FORMA_DE_PAGO, 
                        VIEW_TABLA_GENERAL_DETALLE, 
                        VIEW_MONEDA 
         where  MDMO.motipoper = 'CP' --and MDMO.mostatreg is null
  and    MDMO.morutcart = MDRC.rcrut
         and   VIEW_CLIENTE.clrut = MDMO.morutcli 
         and   VIEW_CLIENTE.clcodigo = MDMO.mocodcli 
        and    MDMO.morutcart = MDCI.cirutcart
         and    MDMO.monumdocu = MDCI.cinumdocu
         and    MDMO.mocorrela = MDCI.cicorrela
  and    MDMO.morutemi  = MDEM.emrut
  and    MDMO.mocodigo  = incodigo
         and    VIEW_TABLA_GENERAL_DETALLE.tbcateg   = 204      
         and    convert(numeric(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)  = isnull( MDMO.motipcart, 0)
         and    VIEW_MONEDA .mncodmon  = isnull( MDMO.momonemi, 0)
 --      and    VIEW_MONEDA.mncodmon  = isnull( MDMO.momonpact, 0)
         and    VIEW_FORMA_DE_PAGO.codigo    = isnull( MDMO.moforpagi, 0) 
          order by MDMO.monumoper + MDMO.mocorrela  
  end
end
                                                                                                                  
                                                                                                                  


GO

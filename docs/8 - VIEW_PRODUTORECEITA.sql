CREATE VIEW VIEW_PRODUTORECEITA
AS
select receita.id id_receita
     , produto.id id_produto
     , produto.nome
  from pedidovenda
inner join pedidovendaitem on pedidovenda.id = pedidovendaitem.id_pedido
inner join produto on pedidovendaitem.id_produto = produto.id
inner join receita on pedidovenda.id = receita.id_pedido
inner join receitaitem on receita.id = receitaitem.id_receita and
           pedidovendaitem.id = receitaitem.id_pedidovendaitem

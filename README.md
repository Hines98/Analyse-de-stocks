## Contexte
La société Mint Classics, un détaillant de modèles réduits de voitures classiques et d'autres véhicules, envisage de fermer l'un de ses entrepôts.
Pour soutenir une décision commerciale basée sur les données, elle recherche des suggestions et des recommandations pour réorganiser ou réduire ses stocks tout en maintenant un service rapide pour ses clients. Par exemple, elle souhaite pouvoir expédier un produit à un client dans un délai de 24 heures après la passation de commande.
En tant qu'analyste de données, j'ai été chargé d'utiliser MySQL Workbench pour me familiariser avec l'activité générale en examinant les données actuelles. Les requêtes que je vais écrire doivent permettre de répondre à des questions comme :
1.	Où sont stockés les articles et, si une réorganisation était effectuée, serait-il possible de supprimer un entrepôt ?
2.	Comment les niveaux de stock sont-ils liés aux chiffres de vente ? Les quantités en stock semblent-elles appropriées pour chaque article ?
3.	Stockons-nous des articles qui ne se vendent pas ? Certains produits pourraient-ils être retirés de la gamme ?

## Objectifs du projet
1.	Explorer les produits actuellement en stock.
2.	Identifier les facteurs importants susceptibles d'influencer la réorganisation ou la réduction des stocks.
3.	Fournir des analyses et des recommandations basées sur les données.

## Défi
Mon défi est de mener une analyse exploratoire des données pour identifier des motifs ou des tendances pouvant influencer la réduction ou la réorganisation des stocks dans les entrepôts de Mint Classics.

#### [Télécharger les requêtes SQL]()
#### [Télécharger les résultats des requêtes SQL]()

## Analyse 
### 1. Répartition actuelle des stocks 
Actuellement, la répartition des stocks par entrepôt sur la période étudiée (01-2003 au 05-2005) est la suivante :
- Entrepôt Est (b) : 219 183 – Variété de voitures
- Entrepôt Nord (a) : 131 688 – Mix de motos et avions
- Entrepôt Ouest (c) : 124 880 – Modèles de voitures anciennes
- Entrepôt Sud (d) : 79 380 – Trains, bus, bateaux, véhicules utilitaires
110 variétés de produits sont répartis dans ces 4 entrepôts avec un délai de livraison moyen de 4 jours pour tous les entrepôts. 

### 2. Analyse des ventes et du stock
- L’entrepôt Sud est le plus performant en termes de ventes sur la période étudiée. Son taux de ventes est de 22%, ce qui indique une rotation des stocks plus rapide que dans les autres entrepôts qui ont écoulé 14 à 16% de leur stock.
- Certains produits ayant enregistré des ventes élevées ont des niveaux de stock relativement bas en comparaison avec d'autres produits moins vendus (voir la liste). Leur stock reste correct mais pourrait nécessiter un suivi si les ventes restent élevées (demande croissante).
À l’inverse, certains articles avec un stock élevé comme la ‘1999 Indy 500 Monte Carlo SS’ (865 vendus et 8154 toujours en stock) n'ont pas un volume de ventes proportionnellement important ou ne sont tout simplement pas vendus comme la '1985 Toyota Supra' avec 0 vente et 7733 en stocks depuis 2 ans. Ce stockage disproportionné par rapport aux ventes peut entraîner l’immobilisation de l’espace, des coûts de stockage élevés et des problèmes de liquidité.
Au total, 89 variétés de produits sont en surstocks avec une proportion de 82% concentré qui dans les entrepôts Nord, Est et Ouest.

### Conclusion et recommandations globales
- Suivi des produits à forte demande : s’assurer que les niveaux de stock sont suffisants pour éviter des ruptures.
- Réduction des stocks excédentaires : faciliter l’écoulement  via des promotions, remises ou revente à d’autres distributeurs. Les articles invendus depuis longtemps devraient être retirés ou déstockés.
- Optimisation des coûts de stockage : avec une réduction des stocks excédentaires et une analyse complémentaire (données de coûts de stockage non fournies), nous pourrons identifier lequel des entrepôts a le coût de stockage le plus élevé et si une fusion partielle des stocks est possible pour supprimer ou réduire l’activité d’un site.

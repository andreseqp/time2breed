/*=============================================================================
Breeding time
===============================================================================
Source files of a computer simulation program that models the evolution of social 
effects on breeding time.
Individuals evolve the sensitivity to include in their decision making process of 
when to breed the reproductive status of their conspecifics. We start with an asexual
model. Where individuals can use an environmental cue to decide when during the year 
to breed. This environmental cue is partly correlated with the abundance of 
resources along the season. These resources are necessary to raise the offspring, 
and thus reproductive success (or offspring survival) depends on the per capita 
availability of resources. The perception of the environmental cue by each individual 
is prone to errors. So, the mismatch of between the perceived cue, and the resource 
variation not predicted by the environmental cue, could potentially trigger individual
breeding at the wrong time. Hence, individuals could improve their decision making by 
taking into account the breeding status of their peers, which could potentially 
improve the accuracy of their decision. This flexibility comes with a potencial cost. 
If all individuals respond to the social influence, breeding time might end up being 
overly concetrated in time, which, due to density dependence, might reduce the 
reproductive success. Thus, depending on the strength of the intra-specific competition,
it might be better for individuals to respond less to their peers. 

The question of breeding time in a sexual population has some interesting complications.
The balance between information aquisition and intra-specific competition described
above applies to females only. For whom resources for offspring provisioning is of 
outmost importance. For males however, it´s more important to find mates. Thus, 
environmental information is useful for males only as a proxy of female availability. 
Perhaps, the social influence is a more direct cue of the availability of reproductive 
females. This does not mean that males do not experience density dependence effects. 
If a male happens to be reproductively active when abunduce of females is low, but 
abundance of reproductively active males even lower, such male might enjoy a high 
reproductice success. Which opens up the question, what is the best strategy for a 
male to decide when to become reproductively active?

We aim to answer the above questions using a individual based model. In such model,
individuals have genotypes that define their response to a enviromental cue, as well 
as the reproductive status of other individuals. The decision of whether to breed at a


Written by :

Andrés E.Quiñones
Posdoctoral researcher
Departamento de ciencias biológicas
Universidad de los Andes
Bogotá Colombia

Start date :
10 December 2019
=============================================================================*/
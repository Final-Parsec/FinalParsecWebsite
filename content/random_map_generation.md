title: Using Cellular Automata to Create a Random Map Generator
Date: 2014-03-31
Category: Nauticus
Tags: nauticus, map-generation
Slug: nauticus-map-generation
Author: Matt
Summary: Learn how to programmatically generate earth-like terrain using cellular automata.

<h2>Introduction to Cellular Automata</h2>

<p>A cellular automaton consists of a grid of cells, each in one of a finite number of states, such as on and off. The grid can be in any finite number of dimensions. For each cell, a set of cells called its neighborhood is defined relative to the specified cell. An initial state is selected by assigning a state for each cell. A new generation is created, according to some fixed rule that determines the new state of each cell in terms of the current state of the cell and the states of the cells in its neighborhood. </p>

<h2>The Game of Life</h2>

<p>In the classic model of Cellular Automata (CA) Conway's Game of Life, the cells follow four simple rules. <p>

<ol>
	<li>Any live cell with fewer than two live neighbors dies, as if caused by under-population.</li>
	<li>Any live cell with two or three live neighbors lives on to the next generation.</li>
	<li>Any live cell with more than three live neighbors dies, as if by overcrowding.</li>
	<i>Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.</li>
</ol>

<p>These simple rules ended up evolving complex patterns capable of motion and self-replication.So, if we take the ideas from this and apply them to map generation we should be able to create unique worlds for players to explore.</p>

<h2>Applying CA to Map Generation</h2>

<p>In Conway's Game of Life the cell is either alive or dead and always stays in one location (Although patterns can give the appearance of motion). For map generation we are going to create agents to move fromtheir current cell to one of the neighboring cells.</p>

<h3>Creating Agents</h3>

<p>Agents work with a given set of rules. The rules of an agent are determined by what you want that agent to accomplish. Maybe you want an agent that can create meandering rivers, lakes, or mountain ranges. Rules can be developed to create all of these things. For this example we are only going to create on set of rules for all of our tile types.</p>

<p>We want our agents to create groupings of tiles that are the same, while still having an element of randomness. To accomplish this we have 2 simple rules.</p>

<ul>
	<li>An agent can only move to a neighboring tile that is not the same type that the agent is creating.</li>
	<li>An agent is more likely to move to a tile if that tile has more neighboring tiles of the agent's type.</li>
</ul>


<h3>Initial State</h3>

<p>Initially I fill my map with one tile type, grass. Then I create a random number of Tree Agents, Mountain Agents, and Water Agents and place them randomly on the map.</p>

<p>Each agent is given a number of times they are allowed to move. When they run out of moves or they can't find a new place to move to, they are killed. The maps that are created can be varied by changing the number of agents that are used or by changing the number of times they are allowed to move. I start by filling a percentage of the map with agents and then give them a random number from a range to determine how far they can move.</p>

<h3>Examples</h3>

<p>Here are two example maps that my agents created. The larger map is 200x200 and the smaller map is 50x50.</p>

<img src="/theme/images/random_map_generation_1.png" style="width: 95%;" />

<img src="/theme/images/random_map_generation_2.png" style="width: 95%;" />

<p>
<strong>Cell</strong> A cell is a location inside the Map that contains a cell type that is manipulated by an agent.<br><br>
<strong>Cell Type</strong> The type of cell it is. Our cells have the following types Grass, Mountain, Water, and Tree.<br><br>
<strong>Map</strong> The map is a 2-dimensional plane that is separated into an NxM matrix of cells.<br><br>
<strong>Neighborhood/Neighbors</strong> The neighborhood of a cell consists of any cell that is touching or diagonal to the current cell.<br><br>
	















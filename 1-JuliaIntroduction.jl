### A Pluto.jl notebook ###
# v0.19.38

using Markdown
using InteractiveUtils

# ╔═╡ 85f1576f-3899-4a13-93bd-fc8b2e663949
###start_implementation
using SparseArrays
###end_implementation

# ╔═╡ f57d431e-d43b-486b-b073-c3815e1e8cc8
###start_implementation
begin
	#Erste Buchstabe J
	using LinearAlgebra 
	A = zeros(20, 15)
	A[1, 1:end] .= 1
	A[1:12, end] .= 1
	for i = 12:size(A, 1)
		for j = 1:size(A, 2)
			if isapprox(norm([12, 7.5]-[i, j]), 7.5, atol=0.5)
				A[i, j] = 1
			end
		end
	end
	sparse(A)
end
###end_implementation

# ╔═╡ e50990fd-30e4-47de-ae83-d4c6e442990f
begin
	using Test
	# filled arrays
	# Vector
	a4 = [3, 3, 3]
	@show a4
	a5 = [1:10]
	@show a5
	# Matrix
	a6 = [1 1 1; 2 2 2; 3 3 3]
	@show a6
	a7 = rand(Int16, 5, 5)
	@show a7

	# access array values
	v1 = a7[2,2]
	@show v1

	a8 = Int64[]

	for i = 1:100
		push!(a8, i) 
	end

	@test sum(a8) == 101*100/2

	a9 = [1, 2, 3]
	@show a9 .+ a9

	# Lets test a matrix-vector product
	@test a9 == a6 * [1, 0, 0]
end

# ╔═╡ 52d6bf41-1023-4f31-9f96-2c8ac264071d
md"""
Glückwunsch, Sie haben erfolgreich Julia installiert und gestartet, und dann das Package Pluto.jl hinzugefügt, und daraus dieses Notebook gestartet!
Jetzt können wir anfangen!

# Einführung in Julia
[Julia](https://julialang.org/) ist eine relativ neue Programmiersprache (Version 1.0 2018). Sie wurde speziell zur Implementierung von numerischen Algorithmen entwickelt und soll die Geschwindigkeit von C oder Fortran mit dem Bedienkomfort von Python oder Matlab verbinden. Das wird dadurch erreicht, dass Julia just-in-time kompiliert wird (während C oder Fortran vor dem Ausführen kompiliert wird, und Python und Matlab interpretiert werden). 

Darüber hinaus unterstützt Julia Metaprogrammierung, was auf Ideen aus Lisp basiert. In diesem Kurs werden wir uns aus Zeitgründen nicht mit Metaprogrammierung beschäftigen, sondern uns nur mit den Features beschäftigen, die wir in den folgenden Praktikastunden brauchen.

Da wir in diesem Kurs Pluto Notebooks zum Programmieren verwenden, erstmal ein kurzer Überblick darüber, wie diese funktionieren. Sie sollten hier eine Zelle sehen, in der ein paar Zahlen stehen - klicken Sie in die Zelle, und dann Shift + Enter! Alternativ können Sie auch den run button rechts unter der Zelle verwenden. Dort wird auch die Zeit angezeigt, die das ausführen der Zelle gedauert hat.
"""

# ╔═╡ 2b11aeee-0826-42cd-822c-94be5861fddb
a = 50 - 5 * 4 + 12

# ╔═╡ 6885dfd4-520e-4d17-b55e-5f31979d6e19
md"""
Hier ist eine weitere Zelle für Sie zum Ausprobieren:
"""

# ╔═╡ 8a07e1f7-a0f1-402c-be74-810a47990ced


# ╔═╡ 4289de89-1e43-41ea-8531-337e08b9c031
md"""
Um selbst eine weitere Zelle hinzuzufügen, kann das + auf der linken Seite über oder unter der aktuellen Zelle verwendet werden. Um den Input einer Zelle zu verstecken und nur den Output anzuzeigen, kann das Auge links neben der Zelle verwendet werden - auf diese Weise erstelle ich diese Textblöcke!
"""

# ╔═╡ 2ba627e9-788a-41fa-9156-2153857c1c32
md"""
Bei den drei Punkten rechts oben in der Zelle können Zellen gelöscht und deaktiviert werden. Das deaktivieren kann besonders dann sinnvoll sein, wenn das Ausführen einer Zelle sehr lange dauert, da immer wenn ein Teil des Notebooks aktualisiert wird, auch alle Zellen die von dieser Änderung betroffen sind, wieder durchlaufen. Probieren Sie dies ruhig mit dem Beispiel unten aus:
"""

# ╔═╡ 0a3a689e-f9c7-4e41-9c7a-074cdf5ee9a0
x = -1

# ╔═╡ 5e57955d-7026-4db2-ae84-c2842e40c7a8
y = 2

# ╔═╡ 08633e97-2de1-492d-aaf4-285beadace83
z = x - y

# ╔═╡ 20fa2f2c-93f6-4a26-8ff7-f7758500d4cc
md"""
Wenn mehrere Ausdrücke in derselben Zelle stehen sollen, müssen diese in Pluto mit einem "begin-end" Block umschlossen werden. Was in Pluto leider nicht geht, ist eine bereits an anderer Stelle verwendete Variable zu überschreiben. a habe ich oben bereits verwendet, wenn ich nun versuche a einen Wert zuzuweisen bekomme ich eine Fehlermeldung, bzw. wird die Zelle, in der a vorher definiert wurde, in den neuesten Pluto Versionen deaktiviert - das liegt daran, dass das automatische aktualisieren aller Zellen nicht mehr funktionieren würde, wenn a an verschiedenen Stellen Werte bekommt!
"""

# ╔═╡ cb249286-96b3-4f4c-9eb9-f5bfef594742
begin
	t = 0
	for i in 1:3
		t += 1
		@show t
	end
end

# ╔═╡ 74ecc059-1f5f-4d82-a534-3a13102fa645
# ╠═╡ disabled = true
#=╠═╡
a = 5
  ╠═╡ =#

# ╔═╡ e499d96e-2f3f-4287-a024-558aa5aefc2a
md"""
# Julia basics
## Datentypen
In Julia gibt es alle gängigen Datentypen. Interessant sind für uns vor allem `Int64` (64-bit große Ganzzahlen) und `Float64` (64-bit große reelle Zahlen, also *double precision*). Daneben kennt Julia sogenannte *abstrakte* Datentypen, wie etwa `Integer`.

!!! tip
	Variablen werden in Julia immer klein geschrieben. Ein Variablenname, der sich aus verschiedenen Wörtern zusammensetzt, wird zusammengeschrieben. Wird der Name einer Variable aber zu lang oder wird er missverständlich, können Unterstriche zur Trennung der Wortbestandteile verwendet werden.
### Integer
"""

# ╔═╡ f692b4a7-82be-4379-bbaf-7273d8c72e15
begin
	# Integer
	i1 = 1
	@show typeof(i1)
	@show i1 isa Integer
end

# ╔═╡ b54f6a71-ec6c-4194-96b6-d373ecf88f7e
md"""
Julia erzeugt per default ein Integer in 64-Bit-Darstellung. Um 16- oder 32-Bit zu verwenden, muss der Konstruktur des Datentyps verwendet werden.
"""

# ╔═╡ 483ed423-fcbf-46cc-8bfe-ea3d5b787876
begin
	i2 = 1
	@show typeof(i2)
	i2 = Int32(1)
	@show typeof(i2)
	i2 = Int16(1)
	@show typeof(i2)
end

# ╔═╡ 8a01477f-774c-47a0-81ee-183c8e876f1a
md"""
### Gleitkommazahlen
Gleitkommazahlen funktionieren analog zu den Ganzzahlen. Interessant ist hier die Genauigkeit mit der eine Float Operation berechnet wird. Diese können wir uns mit `eps()`-Funktion anzeigen lassen.
"""

# ╔═╡ 78c8d5a0-72d9-49bd-875f-d87eac11f992
begin
	# Float
	f1 = 1.0
	@show typeof(f1)
	@show f1 isa Float64
	@show eps(f1)
	
	f1 = Float32(1.0)
	@show eps(f1)
	
	f1 = Float16(1.0)
	@show eps(f1)

	f1 = BigFloat(1.0)
	@show eps(f1)
end

# ╔═╡ fe89b668-b3ba-4270-a82a-f4d72e3c514e
md"""
## Datenstrukturen
Datenstrukturen funktionieren in Julia wie in den meisten anderen Programmiersprachen. Ein Vorteil von Julia ist, dass der Typ der einzelnen Parameter einer Datenstruktur durch *parametric types* definiert werden kann. Die Festlegung des Typs des Parameters geschieht dabei erst bei Initialisierung der Datenstruktur.
Der Datentyp eines Elements muss nicht zwingend spezifiert werden. Das birgt aber das Risiko, dass langsamer Code erzeugt, da es die Wahrscheinlichkeit erhöht, dass der Compiler nicht weiß, welcher Datentyp vorliegt. Alternativ könnte man konkrete Datentypen spezifieren. Häufig möchte man das allerdings nicht, da man die Wahlfreiheit haben will, einen genaueren/größeren, aber langsameren Datentyp, oder einen ungenaueren/kleineren, aber schnelleren Datentyp zu wählen.

!!! tip
	Datenstrukturen werden in Julia immer groß geschrieben. Einzelne Wörter werden durch *CamelCase*-Notation „getrennt“.

"""

# ╔═╡ 55d46841-bd75-4026-9282-69bc3f8cea9b
struct MixedNumbers{I, F}
	i1::I
	i2::I
	f1::F
	f2::F
	f3::Float32
	f4
end

# ╔═╡ 5d1fd4a7-3711-4b90-83c8-85f1584cd6be
md"""
Durch die Verwendung der parametric types `I` und `F` wird hier lediglich festgelegt, das die Variablen `i1` und `i2` bzw. `f1` und `f2` jeweils den gleichen Typ haben müssen.
"""

# ╔═╡ c3a88e6d-a63d-446d-b111-08a2d2acd48d
begin
	mn = MixedNumbers(1, 2, 1.0, 2.0, 3.0f0, BigFloat(4.0))
	
	@show mn.i1
	@show typeof(mn.i1)
	@show mn.f1
	@show typeof(mn.f1)
	@show typeof(mn.f3)
	@show typeof(mn.f4)
	@show typeof(mn)
end

# ╔═╡ d5c28f40-daa2-4f55-892f-b0b872775900
md"""
## Funktionen
Ähnlich wie bei den Datenstrukturen können die Typen der Inputparameter einer Funktion durch *parametric types* festgelegt werden. Dies kann genutzt werden, um festzulegen, welche Parameter vom gleichen Typ sein müssen, ohne festzulegen, welcher Typ es sein muss.

Eine weitere nützliche Funktionalität in Julia ist, dass Funktionen überladen werden können, das bedeutet, dass mehrere Funktionen mit gleichem Namen aber unterschiedlichen Inputparametern definiert werden können.

!!! tip
	Funktionsnamen werden in Julia wie Variablennamen behandelt.

!!! tip
	Funktionen, die einen Inputparameter verändern aber keinen Rückgabetyp haben, bekommen ein Ausrufezeichen angehängt.
"""

# ╔═╡ 82a8a074-e849-4578-9621-c6ec129efb0a
function pythagoras(a::F, b::F) where F <: Real
	c = sqrt(a^2 + b^2)
	return c
end

# ╔═╡ 091426b5-a7d1-42e8-bc04-b784f9c9d580
md"""
*Parametric types* sind besonders nützlich, um konsistente Datentypen zu gewährleisten: In der Regel möchte man, dass der die Argumente einer Funktionen zum Rückgabewert korrespondieren. Was würde passieren, wenn wir `1.0` anstatt `F(1.0)` verwenden würden?
"""

# ╔═╡ 3dad9f90-745b-4b7b-9be1-7d4e0ecca621
function plusone(a::F) where F
	return a + F(1.0)
end

# ╔═╡ ef398c03-f180-44a7-a382-05c4810c515a
begin
	@show plusone(Float32(2.0))
	@show eltype(plusone(Float32(2.0)))
end

# ╔═╡ c5e16094-c2f3-4920-8258-9a13dc3d05cc
md"""
Funktionen sollten immer dokumentiert werden. Untenstehenden finden Sie ein Beispiel.
"""

# ╔═╡ 4da88729-e435-48c2-b85c-4d7bf4a0d30d
"""
	add(a, b)

Returns the sum of the values `a` and `b`.
"""
function add(a, b)
	return a + b
end

# ╔═╡ 87b84969-1a5b-4174-92b3-482e8b919892
md"""
## Syntax
### `if`-Abfragen
In Julia können `if`-Abfragen mit beliebig vielen Abfragen erzeugt werden. Dabei wird mit einer `if`-Abfrage gestartet und alle weiteren Abfragen mit `elseif` angehängt. Ein `else`-Statement ist optional und abgeschlossen wird meinem einem `end`.

Es stehen die üblichen logischen Operatoren zur Verfügung

| Operator | Bedeutung |
| -------- | --------- |
| !x | Negation |
| x && y | kurzschließendes und |
| x \|\| y | kurzschließendes oder |

und die folgenden Vergleichsoperatoren:

| Operator | Bedeutung |
| -------- | --------- |
| x == y | Gleichheit |
| x != y | Ungleichheit |
| x > y | ist größer als |
| x >= y | ist größer als oder gleich wie |
| x < y| ist kleiner als |
| x <= y | ist kleiner als oder gleich wie |
"""

# ╔═╡ 70c921d7-3482-4cdb-b6ef-b57161b68f8a
begin 
	var1 = 1.0
	if var1 isa Integer
		println("Integer")
	elseif var1 isa Float64
		println("Float")
	else
		println("No Float or Integer")
	end

	if (1.0 > 1.5) || (1.0 < 2.0)
		println(true)
	end

	# This is a neat way to make an if-statement
	# in a single line: if the first statement is true
	# the second statement will be executed
	# There is no problem that the second statement
 	# is not a Boolean
	3 == 3 && println("Hello World")
end

# ╔═╡ dbb6962b-8037-4c7c-9ea4-cee62734946d
md"""
### Arrays, Matrizen und Vektoren
In Julia gibt es die Typen `Matrix{T}` und `Vector{T}`. Beide zählen zu dem übergeordneten Typ `Array{T}`. Vektoren sind eindimensionale Arrays und Matrizen zweidimensional.

!!! tip
	Arrays sollten wenn möglich immer voralloziert und nicht in einer Routine vergrößert werden. 
"""

# ╔═╡ fcce5f8b-f885-42d7-a505-7dbabaf3ba10
begin
	# empty arrays
	# Vector
	a1 = zeros(Float64, 5)
	@show typeof(a1)
	# Matrix
	a2 = zeros(Float64, 5, 5)
	@show typeof(a2)
	# Array
	a3 = zeros(Float64, 5, 5, 5)
	@show typeof(a3)
	# Vector, but not initialized
	# If entries overwritten anyhow (without read),
	# then this faster than zeros()
	u1 = Array{Float64}(undef, 5)
	@show typeof(u1)
end

# ╔═╡ a1039ba8-845b-4440-ac1d-23b00c79193b
md"""## Testing
Oben sehen Sie bereits das `using Test` und den Gebrauch des `@test`-Makros. Was hier passiert, ist dass überprüft dass ein bestimmter Ausdruck `true` ist. Ist dieser stattdessen `false` erhalten Sie einen Fehler. 

!!! tip
	In der Praxis werden Tests genutzt, um zu überprüfen, dass alle Funktionen im Code genau das machen was sie sollen. Wenn später etwas an Funktionen verändert oder erweitert wird, kann man durch das Ausführen aller Tests sicherstellen, dass die vorher bereits vorhandenen Funktionalitäten nicht aus Versehen verändert wurden.
"""

# ╔═╡ b73f4241-3b19-4a28-ab7b-bb98d61b435f
md"""
## `for`-Schleifen
Anders als zum Beispiel in Matlab sind in Julia `for`-Schleifen oft die beste Wahl. In vielen Fällen kann eine `for`-Schleife durch ein Matrix-Matrix oder Matrix-Vector Produkt ersetzt werden. Dies ist in den meisten Fällen schlechter lesbar und in Julia auch nicht zwingend die schnellere Variante.

Julia bietet mehrere Möglichkeiten, wie der Kopf der Schleife aussehen kann.

#### Beispiele
```julia

a = [5:10]

# iterating over each element in a
for element in a
	...
end

# iterating over each index of array a
for index in eachindex(a)
	...
end
# equivalent to (can become problematic if startindex is changed)
for index = 1:length(a)
	...
end

# iterating over each element of a, retrieving index and element
for (index, element) in enumerate(a)
	...
end

#iterating over a range
for i = 1:10
	...
end
```
"""

# ╔═╡ 2c3da2a9-e31d-41ed-93c9-ab6a205612ad
md"""
## Unicode Unterstützung
Julia unterstützt Unicode, alle Unicode Zeichen können im Code verwendet werden. So können beispielsweise Variablennamen griechische Buchstaben sein, was beim Programmieren von mathematischen Funktionen sehr hilfreich ist, da Variablen die gleiche Bezeichnung wie in den Gleichungen haben können. Eine Übersicht über alle unterstützten Zeichen finden Sie [hier](https://docs.julialang.org/en/v1/manual/unicode-input/). 
!!! tip
	Sie können die Buchstaben eingeben, indem Sie einen Backslash und den Namen des Symbols tippen, mit der Tab-Taste wird dies dann in das entsprechende Symbol umgewandelt.
"""

# ╔═╡ a9bf6a30-81cf-4206-9406-a1301054fbf5
begin
	ρ(x) = x
	ε₀ = 8.854e-12
	ΔΦ(x) = -ρ(x) / ε₀

	ΔΦ(5)
end

# ╔═╡ 58bbe0e0-e71d-4503-9cb8-ec3beb740d16
md"""
# Aufgaben

!!! warning \"Aufgabe 1.1 Sparse Arrays\"
	Laden Sie das Paket `SparseArrays`.
"""

# ╔═╡ d33f2f22-24ce-401b-a93e-eada34a2d076
md"""
!!! warning \"Aufgabe 1.2 Sparse Arrays\"
	Erzeugen Sie eine Matrix `A` mit 20 Zeilen und 15 Spalten, wobei alle Einträge der Matrix 0 sein sollten.
	Wenn Sie die Funktion `sparse(A)` aufrufen, wird ihre Matrix als Bild ausgegeben, wobei alle Einträge, die ungleich 0 sind, schwarz dargestellt werden. 
	Füllen Sie nun die entsprechenden Einträge der Matrix mit einsen, sodass ihr Anfangsbuchstabe erscheint, wenn Sie `sparse(A)`aufrufen. 
"""

# ╔═╡ 6c88a32e-26d8-4edd-a5bc-3a1570fafe53
md"""
!!! warning \"Aufgabe 1.3 Initialisierung von Arrays\"
	Erzeuge ein zweidimensionales quadratisches Array mit 10.000 Einträgen, wobei jeder Elementwert der Summe aus Spalten- und Zeilenindex entspricht.
	Benutzen Sie das `@test`-macro, um das Ergebniss stichprobenartig zu testen. 
"""

# ╔═╡ 035c14b0-0d0e-4f9b-8656-9f3d9c2bb6b1
###start_implementation
begin
	A2 = zeros(Int, 100, 100)
	for i in 1:size(A2, 1)
		for j in 1:size(A2, 2)
			A2[i, j] = i + j
		end
	end
	
	@test A2[2, 3] == 5
	@test A2[20, 40] == 60
end
###end_implementation

# ╔═╡ 7068bc90-93a0-43c3-a5ed-65ba3db70dfc
md"""
!!! warning \"Aufgabe 1.4 Iteratives Updaten\"
	Erzeuge einen Vektor mit 100 Einträgen, wobei alle Werte auf null gesetzt werden.

	Setzen Sie zwei zufällige Werte auf den Wert eins.
	
	Schreibe nun eine Funktion `propagate!()`, die als Inputparameter einen Vektor bekommt. Die Funktion soll den Vektor iterativ updaten. In jedem Update soll jedes benachbarte Element einer eins ebenfalls auf den Wert 1 gesetzt werden. 
	Sind alle Elemente des Vektors eins, soll die Funktion die Anzahl der benötigten Iterationen zurückgeben. 
"""

# ╔═╡ 3bf53b5e-24e4-48d3-a53e-f3bfc25677fa
###start_implementation
function propagate!(v::Vector{I}) where I
	vc = copy(v)
	i=0
	while i < 100
		if minimum(v) == 1
			return i
		end
		i += 1
		for i in eachindex(v)
			if vc[i] == 1
				if i > 1 && i < length(v)
					v[i-1] = 1
					v[i+1] = 1
				elseif i == 1
					v[2] = 1
				elseif i == length(v)
					v[end-1] = 1
				end
			end
		end
		vc .= v
	end
	
	if i == 100
		return "failed"
	end
end
###end_implementation

# ╔═╡ c98aba96-ca0b-40bd-84ae-356783824ca2
###start_implementation
begin
	v = zeros(Int, 100)
	v[[25, 75]] .= 1
	propagate!(v)
end
###end_implementation

# ╔═╡ 11de374f-381e-4e9e-9396-3b3b5068f8cb
md"""
!!! warning \"Aufgabe 1.5 Pythagoreische Tripel\"
	Die Zahlen a=3, b=4 und c=5 bilden ein pythagoreisches Tripel, das bedeutet das a²+b²=c², wobei a, b und c ganze Zahlen sind. 
	Es gibt ein solches Tripel, bei dem die Summe aus a, b und c 1000 ist. Dieses wollen wir finden. 
"""

# ╔═╡ 0cf55708-679b-4bb8-8650-885fcb1a86d2
begin
###start_implementation
	struct triplet
		a::Int64
		b::Int64
		c::Int64
	end

	function sumtriplets(x::triplet)
		return x.a + x.b + x.c
	end
	
	N = 500
	
	triplets = triplet[] # empty vector of type triplet
	
	squares = [i^2 for i in 1:N] # first N square numbers
	for (i,p) in enumerate(squares)
		for (j,q) in enumerate(squares[i:end])
			if (p + q) ∈ squares
				append!(triplets,[triplet(i,i+j-1,findfirst(squares.==p+q))])
			end
		end
	end
end

# ╔═╡ bd7f4f5a-f71f-46fd-bd3e-54f5537a441b
# test if the found triplets are really pythagorean:
begin
		@test sumtriplets(triplet(1,2,3)) == 6
	for i in eachindex(triplets)
		@test triplets[i].a^2+ triplets[i].b^2 == triplets[i].c^2
	end
end

# ╔═╡ 4e9c1f57-9719-442a-8bd4-74b1f65aac74
begin
	# find the triplet with sum 1000
	triplets[findfirst(sumtriplets.(triplets).==1000)]
###end_implementation
end


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "c9c0bb2ff095154d47cfcc3dc6c745795e08806a"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─52d6bf41-1023-4f31-9f96-2c8ac264071d
# ╠═2b11aeee-0826-42cd-822c-94be5861fddb
# ╟─6885dfd4-520e-4d17-b55e-5f31979d6e19
# ╠═8a07e1f7-a0f1-402c-be74-810a47990ced
# ╟─4289de89-1e43-41ea-8531-337e08b9c031
# ╟─2ba627e9-788a-41fa-9156-2153857c1c32
# ╠═0a3a689e-f9c7-4e41-9c7a-074cdf5ee9a0
# ╠═5e57955d-7026-4db2-ae84-c2842e40c7a8
# ╠═08633e97-2de1-492d-aaf4-285beadace83
# ╟─20fa2f2c-93f6-4a26-8ff7-f7758500d4cc
# ╠═cb249286-96b3-4f4c-9eb9-f5bfef594742
# ╠═74ecc059-1f5f-4d82-a534-3a13102fa645
# ╟─e499d96e-2f3f-4287-a024-558aa5aefc2a
# ╠═f692b4a7-82be-4379-bbaf-7273d8c72e15
# ╟─b54f6a71-ec6c-4194-96b6-d373ecf88f7e
# ╠═483ed423-fcbf-46cc-8bfe-ea3d5b787876
# ╟─8a01477f-774c-47a0-81ee-183c8e876f1a
# ╠═78c8d5a0-72d9-49bd-875f-d87eac11f992
# ╟─fe89b668-b3ba-4270-a82a-f4d72e3c514e
# ╠═55d46841-bd75-4026-9282-69bc3f8cea9b
# ╟─5d1fd4a7-3711-4b90-83c8-85f1584cd6be
# ╠═c3a88e6d-a63d-446d-b111-08a2d2acd48d
# ╟─d5c28f40-daa2-4f55-892f-b0b872775900
# ╠═82a8a074-e849-4578-9621-c6ec129efb0a
# ╟─091426b5-a7d1-42e8-bc04-b784f9c9d580
# ╠═3dad9f90-745b-4b7b-9be1-7d4e0ecca621
# ╠═ef398c03-f180-44a7-a382-05c4810c515a
# ╟─c5e16094-c2f3-4920-8258-9a13dc3d05cc
# ╠═4da88729-e435-48c2-b85c-4d7bf4a0d30d
# ╟─87b84969-1a5b-4174-92b3-482e8b919892
# ╠═70c921d7-3482-4cdb-b6ef-b57161b68f8a
# ╟─dbb6962b-8037-4c7c-9ea4-cee62734946d
# ╠═fcce5f8b-f885-42d7-a505-7dbabaf3ba10
# ╠═e50990fd-30e4-47de-ae83-d4c6e442990f
# ╠═a1039ba8-845b-4440-ac1d-23b00c79193b
# ╟─b73f4241-3b19-4a28-ab7b-bb98d61b435f
# ╠═2c3da2a9-e31d-41ed-93c9-ab6a205612ad
# ╠═a9bf6a30-81cf-4206-9406-a1301054fbf5
# ╟─58bbe0e0-e71d-4503-9cb8-ec3beb740d16
# ╠═85f1576f-3899-4a13-93bd-fc8b2e663949
# ╠═d33f2f22-24ce-401b-a93e-eada34a2d076
# ╠═f57d431e-d43b-486b-b073-c3815e1e8cc8
# ╠═6c88a32e-26d8-4edd-a5bc-3a1570fafe53
# ╠═035c14b0-0d0e-4f9b-8656-9f3d9c2bb6b1
# ╠═7068bc90-93a0-43c3-a5ed-65ba3db70dfc
# ╠═3bf53b5e-24e4-48d3-a53e-f3bfc25677fa
# ╠═c98aba96-ca0b-40bd-84ae-356783824ca2
# ╟─11de374f-381e-4e9e-9396-3b3b5068f8cb
# ╠═0cf55708-679b-4bb8-8650-885fcb1a86d2
# ╠═bd7f4f5a-f71f-46fd-bd3e-54f5537a441b
# ╠═4e9c1f57-9719-442a-8bd4-74b1f65aac74
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

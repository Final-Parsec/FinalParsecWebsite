title: Enemy Detection and Firing
Date: 2014-11-23
Category: Tower Defense
Tags: tower-defense, unity, tutorial, turret
Slug: tower-defense-enemy-detection-and-firing
Author: Baer
Summary: Learn how to detect enemies and shoot projectiles at them. A continuation of the tower defense tutorial series.

<p>
    Learn how to make turrets detect enemies and shoot projectiles at them.
    A continuation of the tower defense tutorial series.
</p>


<h3>Setting Up Your Turret GameObject</h3>

<p>
    Go ahead and get started by creating a Sprite in your hierarchy.
</p>
<p>
    This should create a new <a href="http://docs.unity3d.com/Manual/class-GameObject.html" target="_blank">GameObject</a> 
    with the <a href="http://docs.unity3d.com/Manual/class-Transform.html" target="_blank">Transform</a> and 
    <a href="http://docs.unity3d.com/Manual/class-SpriteRenderer.html" target="_blank">Sprite Renderer</a> components        
</p>

<p>  
    Don't worry too much about changing the position; we're going to be setting that programmatically when the player tries to place a turret on the map.
    Do, however, add some cool art to the Sprite property of your renderer.
</p>

<p>
    <span class="caption">This is what we're using for our Earth Type Turrets. Maybe one day we'll hire an artist...</span>
    <img src="/static/images/tower_defense_enemy_detection_and_firing_earth_turret_art.png">
</p>

<p>
    Attach a MonoBehavior script and call it <span style='font-weight: bold;'>Turret.cs</span>.
</p>

<p>
    Attach a <a href="http://docs.unity3d.com/Manual/class-SphereCollider.html" target="_blank">Sphere Collider</a> too.
    Make sure the <span style='font-weight: bold;'>Is Trigger</span> property is checked.
    Don't worry about changing values for <span style='font-weight: bold;'>Center</span> and <span style='font-weight: bold;'>Radius</span>
    as we'll be changing these programmatically.
</p>

<p>
    
    <img src="/static/images/tower_defense_enemy_detection_and_firing_earth_turret_components.png">
    <span class="caption">Your GameObject's components should look something like this.</span>
</p>

<p>
    Go ahead and create a prefab by dragging the turret from your scene to a directory in the project tab.
    Having our turrets as prefabs will give the benefit of being able to instantiate them from code.
    We can even create multiple prefabs which will allow for different turret types, each with their own stats, special abilities, and artwork.
</p>

<h3>Writing the Scripts</h3>

<p>
    Open up the <span style='font-weight: bold;'>Turret.cs</span> attached to your prefab. It should look something like this:
</p>

<pre class='apply-line-numbers'><code class='hljs cs'>using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Turret : MonoBehaviour
{
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}</code></pre>

<span class="caption">Take note I've added a couple <span class='hljs-keyword'>using</span> statements.</span>

<p>
    Let's add some fields and properties. Keep in mind the public fields will be accessible in Unity's inspector panel. 
    <span style='font-weight: bold;'>damage</span>, <span style='font-weight: bold;'>range</span>, and <span style='font-weight: bold;'>rateOfFire</span> are all meant to adjusted there on a 0-10 scale.
    The associated properties <span style='font-weight: bold;'>AttackDelay</span> and <span style='font-weight: bold;'>DetectionRadius</span> scale those values to based on the size of the map.
    <span style='font-weight: bold;'>DetectionRadius</span> also takes responsibility for changing the size of the attached sphere collider. 
</p>

<pre class='apply-line-numbers'><code class='hljs cs'>// Configurable
public float accuracyError = 2.0f;
public int damage = 10;
public GameObject projectileType;
public int range = 5;
public int rateOfFire = 5;

// Constants
private const float MinAttackDelay = 0.1f;
private const float MaxAttackDelay = 2f;

// Internal
private List<EnemyBase> myTargets;
private float nextDamageEvent;
private ObjectManager objectManager;	
private static readonly object syncRoot = new object ();

// Properties
private float AttackDelay
{
    get 
    {
        int inverted = rateOfFire;
        if (rateOfFire == 0) 
        { 
            return float.MaxValue;
        }
        else if (rateOfFire < 5)
        {
            inverted = rateOfFire + 2 * (5 - rateOfFire);
        }
        else if (rateOfFire > 5) 
        {
            inverted = rateOfFire - 2 * (rateOfFire - 5);
        }
        
        return (((float)inverted - 1f) / (10f - 1f)) * (MaxAttackDelay - MinAttackDelay) + .1f;
    }
}

public float DetectionRadius
{ 
    get 
    {	
        float minRange = Mathf.Min(objectManager.Map.nodeSize.x, objectManager.Map.nodeSize.y) * 1.5f;
        float maxRange = minRange * 4f;
        
        float detectionRadius = (((float)range - 1f) / (10f - 1f)) * (maxRange - minRange) + minRange;
        detectionRadius = detectionRadius / transform.localScale.x;
        
        return detectionRadius;
    }
    set 
    {
        float minRange = Mathf.Min(objectManager.Map.nodeSize.x, objectManager.Map.nodeSize.y) * 1.5f;
        float maxRange = minRange * 4f;
        
        float detectionRadius = (((float)value - 1f) / (10f - 1f)) * (maxRange - minRange) + minRange;
        detectionRadius = detectionRadius / transform.localScale.x;
        
        SphereCollider collider = transform.GetComponent<SphereCollider> ();
        collider.radius = detectionRadius;
    }
}</code></pre>

<p>
    Here we initialize some of those private fields.
    <span style='font-weight: bold;'>objectManager</span> is just a singleton we are using to help maintain game state.
    Matt talks more in-depth about it in some of the earlier videos from the <a href="/tag/td-video-series.html">Tower Defense Tutorial Video Series</a>.
</p>

<pre class='apply-line-numbers'><code class='hljs cs'>// Runs when entity is Instantiated
void Awake()
{
    objectManager = ObjectManager.GetInstance();
    objectManager.AddEntity(this);
}

// Use this for initialization
void Start ()
{
    DetectionRadius = range;
    myTargets = new List<EnemyBase>();
}</code></pre>

<p>
    These two methods track when enemies enter and exit the attached sphere collider.
    At any given time, <span style='font-weight: bold;'>myTargets</span> should now reflect all enemies inside the sphere, the turret's detectable area.
</p>
	

<pre class='apply-line-numbers'><code class='hljs cs'>void OnTriggerEnter (Collider other)
{
    if (other.gameObject.tag == "enemy") {	
        myTargets.Add (other.GetComponent<EnemyBase>());
    }
}

void OnTriggerExit (Collider other)
{
    lock (syncRoot) {
        if (other != null &&
            myTargets.Select (t => t!= null && t.gameObject).Contains(other.gameObject)) {
            myTargets.Remove (other.GetComponent<EnemyBase>());
        }
    }
    
}</code></pre>

<h3>Killing Dudes with Projectiles</h3>

<p>
    In order to create a projectile, create a new <a href="http://docs.unity3d.com/Manual/class-GameObject.html" target="_blank">GameObject</a> starting with as a sphere. 
    I ended up adding a <a href="http://docs.unity3d.com/Manual/class-MeshRenderer.html" target="_blank">Mesh Renderer</a> and a <a href="http://docs.unity3d.com/Manual/class-LineRenderer.html" target="_blank">Line Renderer</a> to get it to look like a bullet.
    Attach a MonoBehavior script called <span style='font-weight: bold;'>Projectile.cs</span>.
    Go ahead and make a prefab from this object the same way you did for turrets.
</p>

<p>
     Nothing too crazy going on in this script.
     It requires a target enemy (and associated location) and just homes in on it until it "hits".
     We're not doing any collision detection here, but rather checking distance between the projectile and its target.
     Once the projectile reaches the target, it destroys itself and damages the enemy by subtracting from its health. 
</p>

<pre class='apply-line-numbers'><code class='hljs cs'>using UnityEngine;
using System.Collections;

public class Projectile : MonoBehaviour
{
	// Configurable
	public float range;
	public float speed;
	public EnemyBase target;
	public Vector3 targetPosition;

	public int Damage { get; set; }
	
	// Internal
	private float distance;
	
	// Runs when entity is Instantiated
	void Awake ()
	{
		distance = 0;
	}
	
	// Update is called once per frame
	void Update ()
	{
		Vector3 moveVector = new Vector3 (transform.position.x - targetPosition.x,
		                                 transform.position.y - targetPosition.y,
		                                 transform.position.z - targetPosition.z).normalized;
		
		// update the position
		transform.position = new Vector3 (transform.position.x - moveVector.x * speed * Time.deltaTime,
		                                 transform.position.y - moveVector.y * speed * Time.deltaTime,
		                                 transform.position.z - moveVector.z * speed * Time.deltaTime);
		                                 
		distance += Time.deltaTime * speed;
		
		if (distance > range ||
			Vector3.Distance (transform.position, new Vector3 (targetPosition.x, targetPosition.y, targetPosition.z)) < 1) 
        {
			Destroy (gameObject);
			if (target != null) 
            {
				target.Damage (Damage);
			}
		}
	}
}</code></pre>

<p>
    Now that projectiles are good to go, drag that new projectile prefab onto the <span style='font-weight: bold;'>projectileType</span> field (in the inspector when you've got a turret selected).
    Next, you'll need the following two methods to make the turret "fire" projectiles.
    All we're doing is setting up a loop where the turret instantiates new projectiles targeted at a random enemy within range.
</p>

<pre class='apply-line-numbers'><code class='hljs cs'>void Fire (EnemyBase myTarget)
{
    var targetPosition = myTarget.transform.position;
    var aimError = Random.Range (-accuracyError, accuracyError);
    var aimPoint = new Vector3 (targetPosition.x + aimError, targetPosition.y + aimError, targetPosition.z + aimError);
    nextDamageEvent = Time.time + AttackDelay;
    GameObject projectileObject = Instantiate (projectileType, transform.position, Quaternion.LookRotation (targetPosition)) as GameObject;
    Projectile projectile = projectileObject.GetComponent<Projectile> ();
    projectile.Damage = damage;
    projectile.target = myTarget;
    projectile.targetPosition = aimPoint;
}

// Update is called once per frame
void Update ()
{
    lock(syncRoot)
    {
        if (myTargets.Any())
        {
            EnemyBase myTarget = myTargets.ElementAt(Random.Range(0, myTargets.Count));
            
            
            if (myTarget != null) {
                if (Time.time >= nextDamageEvent)
                {
                    Fire(myTarget);
                }
            }
            else
            {
                nextDamageEvent = Time.time + AttackDelay;
                myTargets.Remove(myTarget);
            }              
        }
    }		
}</code></pre>

<p>
    To fill in some of the gaps like placing turrets on the map and spawning enemies, I encourage you to go take a look at some of the earlier videos from the <a href="/tag/td-video-series.html">Tower Defense Tutorial Video Series</a>. 
</p>